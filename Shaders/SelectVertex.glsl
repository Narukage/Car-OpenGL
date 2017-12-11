
attribute vec4 a_Position_select;	        // in: Posici�n de cada v�rtice

uniform mat4 u_ProjectionMatrix_select; 	// in: Matriz Projection
uniform mat4 u_MVMatrix;	        // in: Matriz ModelView
void main()
{
    vec3 P = vec3(u_MVMatrix * a_Position_select);	            // Posici�n del v�rtice
	gl_Position = u_ProjectionMatrix_select * vec4(P, 1.0);
}
