
attribute vec4 a_Position;	        // in: Posición de cada vértice
attribute vec3 a_Normal;	        // in: Normal de cada vértice

uniform mat4 u_ProjectionMatrix; 	// in: Matriz Projection
uniform mat4 u_MVMatrix;	        // in: Matriz ModelView
uniform mat4 u_VMatrix;             // in: Matriz View (cámara)
uniform vec4 u_Color;		        // in: Color del objeto
uniform int  u_Luz0;                // in: Indica si la luz 0 está encedida
uniform int u_Luz1;
uniform int u_Luz2;
uniform vec4 u_Luz0p;
uniform vec4 u_Luz1p;
uniform vec4 u_Luz2p;
uniform float u_Luz0i;
uniform float u_Luz1i;
uniform float u_Luz2i;



varying vec4 v_Color;		        // out: Color al fragment shader

void main()
{
    vec4 LightPos = u_VMatrix*u_Luz0p;		// Posición de la luz [fija]
    vec4 LightPos1 = u_VMatrix*u_Luz1p;
    vec4 LightPos2 = u_VMatrix*u_Luz2p;
    vec3 P = vec3(u_MVMatrix * a_Position);	            // Posición del vértice
	vec3 N = vec3(u_MVMatrix * vec4(a_Normal, 0.0));    // Normal del vértice
    vec4 position=(u_VMatrix[3][0], u_VMatrix[3][1], u_VMatrix[3][2], u_VMatrix[3][0]);
    vec3 V=normalize(vec3(u_VMatrix*position*vec4(0.0,0.0,0.0,1.0)-P));


	float d = length(LightPos.xyz - P);			        // distancia de la luz
	float d1 = length(LightPos1.xyz - P);
	float d2 = length(LightPos2.xyz - P);
	vec3  L = normalize(LightPos.xyz - P);			    // Vector Luz
    vec3  L1 = normalize(LightPos1.xyz - P);			    // Vector Luz
	vec3  L2 = normalize(LightPos2.xyz - P);			    // Vector Luz


	float ambient = 0.15;                               // (15% de int. ambiente)
	float diffuse = 0.0;
    float diffuse1 = 0.0;
	float diffuse2 = 0.0;
	int n=15;


	if (u_Luz0>0) {                                     // Si la luz 0 está encendida se calcula la intesidad difusa de L
        diffuse = max(dot(N, L), 0.0);		            // Cálculo de la int. difusa
        // Cálculo de la atenuación
        float attenuation = 80.0/(0.25+(0.01*d)+(0.003*d*d));
        float specular=2*attenuation*pow(max(0.0, dot(reflect(-L, N), V)), n);
        diffuse = diffuse*attenuation*u_Luz0i;
        diffuse += specular;
	}

	if (u_Luz1>0) {                                     // Si la luz 0 está encendida se calcula la intesidad difusa de L
        diffuse1 = max(dot(N, L1), 0.0);		            // Cálculo de la int. difusa
        // Cálculo de la atenuación
        float attenuation1 = 80.0/(0.25+(0.01*d1)+(0.003*d1*d1));
        float specular1=2*attenuation1*pow(max(0.0, dot(reflect(-L1, N), V)), n);

        diffuse += diffuse1*attenuation1*u_Luz1i;
        diffuse += specular1;
	}

	if (u_Luz2>0) {                                     // Si la luz 0 está encendida se calcula la intesidad difusa de L
        diffuse2 = max(dot(N, L2), 0.0);		            // Cálculo de la int. difusa
        // Cálculo de la atenuación
        float attenuation2 = 80.0/(0.25+(0.01*d2)+(0.003*d2*d2));
        float specular2=2*attenuation2*pow(max(0.0, dot(reflect(-L2, N), V)), n);

        diffuse += diffuse2*attenuation2*u_Luz2i;
        diffuse += specular2;
	}
	v_Color = u_Color * (ambient + diffuse);
	gl_Position = u_ProjectionMatrix * vec4(P, 1.0);
}
