
attribute vec4 a_Position;	        // in: Posici�n de cada v�rtice
attribute vec3 a_Normal;	        // in: Normal de cada v�rtice

uniform mat4 u_ProjectionMatrix; 	// in: Matriz Projection
uniform mat4 u_MVMatrix;	        // in: Matriz ModelView
uniform mat4 u_VMatrix;             // in: Matriz View (c�mara)
uniform vec4 u_Color;		        // in: Color del objeto
uniform int  u_Luz0;                // in: Indica si la luz 0 est� encedida

varying vec4 v_Color;		        // out: Color al fragment shader

void main()
{
    vec4 LightPos = u_VMatrix*vec4(-7, 10, 9, 1);		// Posici�n de la luz [fija]
    vec3 P = vec3(u_MVMatrix * a_Position);	            // Posici�n del v�rtice
	vec3 N = vec3(u_MVMatrix * vec4(a_Normal, 0.0));    // Normal del v�rtice

	float d = length(LightPos.xyz - P);			        // distancia de la luz
	vec3  L = normalize(LightPos.xyz - P);			    // Vector Luz

	float ambient = 0.15;                               // (15% de int. ambiente)
	float diffuse = 0.0;

	if (u_Luz0>0) {                                     // Si la luz 0 est� encendida se calcula la intesidad difusa de L
        diffuse = max(dot(N, L), 0.0);		            // C�lculo de la int. difusa
        // C�lculo de la atenuaci�n
        float attenuation = 1.0/(0.25+(0.01*d)+(0.003*d*d));
        diffuse = diffuse*attenuation;
	}
	v_Color = u_Color * (ambient + diffuse);
	gl_Position = u_ProjectionMatrix * vec4(P, 1.0);
}
