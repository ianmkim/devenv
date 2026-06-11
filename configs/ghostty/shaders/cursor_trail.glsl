// Cursor trail animation for Ghostty.
//
// Draws a glowing streak from the cursor's previous position to its current
// position that fades out over a short duration. Built on the cursor uniforms
// Ghostty exposes to custom shaders:
//   iCurrentCursor  (vec4): xy = bottom-left, zw = size, in pixels (y from bottom)
//   iPreviousCursor (vec4): same, for the previous cursor location
//   iCurrentCursorColor (vec4): current cursor color (rgba, 0..1)
//   iTimeCursorChange (float): iTime when the cursor last moved
//
// Tunables.
const float DURATION   = 0.25;   // seconds for the trail to fully fade
const float GLOW_WIDTH = 0.6;    // glow falloff (larger = softer/wider)
const float TRAIL_GAIN = 0.45;   // overall trail brightness multiplier

// Signed distance to a line segment (a -> b) from point p.
float sdSegment(vec2 p, vec2 a, vec2 b) {
    vec2 pa = p - a;
    vec2 ba = b - a;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

// Signed distance to an axis-aligned box centered at c with half-size hs.
float sdBox(vec2 p, vec2 c, vec2 hs) {
    vec2 d = abs(p - c) - hs;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Start from whatever Ghostty already rendered (the terminal content).
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    // Cursor centers. The uniform's xy is the TOP-LEFT of the cursor cell in a
    // y-up pixel space (origin bottom-left, matching fragCoord), and the cell
    // extends downward. So center = (x + w/2, y - h/2).
    vec2 curCenter  = vec2(iCurrentCursor.x  + iCurrentCursor.z  * 0.5,
                           iCurrentCursor.y  - iCurrentCursor.w  * 0.5);
    vec2 prevCenter = vec2(iPreviousCursor.x + iPreviousCursor.z * 0.5,
                           iPreviousCursor.y - iPreviousCursor.w * 0.5);

    // How far through the fade we are: 0 = just moved, 1 = done.
    float age = (iTime - iTimeCursorChange) / DURATION;
    if (age >= 1.0) {
        return; // trail fully faded; leave terminal content untouched
    }
    float fade = 1.0 - clamp(age, 0.0, 1.0);

    // Half the cursor cell size, used to scale the glow.
    vec2 halfSize = iCurrentCursor.zw * 0.5;
    float thickness = max(halfSize.x, halfSize.y);

    // Distance from this pixel to the streak connecting the two cursors.
    float d = sdSegment(fragCoord.xy, prevCenter, curCenter);

    // Distance to the live cursor cell, used below to avoid double-glowing it.
    float boxD = sdBox(fragCoord.xy, curCenter, halfSize);

    // Soft glow falloff around the streak.
    float glow = thickness * GLOW_WIDTH / (d + thickness * GLOW_WIDTH);
    glow = pow(glow, 2.0);

    // Fade the glow over its lifetime and away from the live cursor box.
    float boxMask = smoothstep(0.0, thickness, boxD); // 0 inside cursor, 1 outside
    float intensity = glow * fade * boxMask * TRAIL_GAIN;

    vec3 trailColor = iCurrentCursorColor.rgb;
    fragColor.rgb += trailColor * intensity;
}
