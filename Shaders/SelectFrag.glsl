precision mediump float;	// Precisi�n media

uniform int code;		// in: color del vertex shader

void main()
{
    		gl_FragColor = vec4(code/255.0);
}
