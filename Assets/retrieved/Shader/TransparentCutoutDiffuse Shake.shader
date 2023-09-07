Shader "Transparent/Cutout/Diffuse Shake" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
		_ShakeDisplacement ("Displacement", Range(0, 1)) = 1
		_ShakeTime ("Shake Time", Range(0, 1)) = 5
		_ShakeWindspeed ("Shake Windspeed", Range(0, 1)) = 1
		_ShakeBending ("Shake Bending", Range(0, 1)) = 1
	}
	SubShader {
		LOD 200
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			GpuProgramID 60103
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat12 = u_xlat0.y * u_xlat0.y;
					    u_xlat12 = u_xlat0.x * u_xlat0.x + (-u_xlat12);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    vs_TEXCOORD1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat13 = u_xlat1.y * u_xlat1.y;
					    u_xlat13 = u_xlat1.x * u_xlat1.x + (-u_xlat13);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat13) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat6;
					float u_xlat15;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat6.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat6.x * u_xlat1.x;
					    u_xlat6.x = u_xlat6.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat6.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat5.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat5.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat2 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat1.xxxx + u_xlat4;
					    u_xlat3 = u_xlat2 * u_xlat1.zzzz + u_xlat3;
					    u_xlat0 = u_xlat2 * u_xlat2 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat15 = u_xlat1.y * u_xlat1.y;
					    u_xlat15 = u_xlat1.x * u_xlat1.x + (-u_xlat15);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    vs_TEXCOORD1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec2 u_xlat6;
					vec2 u_xlat7;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat7.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat7.x * u_xlat1.x;
					    u_xlat7.x = u_xlat7.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat7.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat6.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat6.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat4 * u_xlat4 + u_xlat0;
					    u_xlat4 = u_xlat4 * u_xlat2.xxxx + u_xlat5;
					    u_xlat4 = u_xlat3 * u_xlat2.zzzz + u_xlat4;
					    u_xlat0 = u_xlat3 * u_xlat3 + u_xlat0;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat3.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat2 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat3.x, u_xlat2);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_7;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat12 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat12, u_xlat6.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat6.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat6.xxx * _LightColor0.xyz;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat0.x = u_xlat2.y * 0.25;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat0.x = max(u_xlat0.x, u_xlat8);
					        u_xlat2.x = min(u_xlat3.x, u_xlat0.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat6.xyz * u_xlat0.xxx + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					vec2 u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat3.x = (-u_xlat0.x) + u_xlat3.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb3){
					        u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat3.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat6.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat6.x, u_xlat3.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat3.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat6.xy);
					    u_xlat3.x = u_xlat3.x + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat2.x;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat0.x) + u_xlat6.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat6.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb12)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat18 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat18, u_xlat12);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat2.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat2 = texture(_ShadowMapTexture, u_xlat2.xy);
					    u_xlat12 = u_xlat12 + (-u_xlat2.x);
					    u_xlat0.x = u_xlat0.x * u_xlat12 + u_xlat2.x;
					    u_xlat0.xzw = u_xlat0.xxx * _LightColor0.xyz;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6.x = u_xlat2.y * 0.25;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat6.x = max(u_xlat6.x, u_xlat8);
					        u_xlat2.x = min(u_xlat3.x, u_xlat6.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat3, u_xlat5);
					        u_xlat3.y = dot(u_xlat4, u_xlat5);
					        u_xlat3.z = dot(u_xlat2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6.x = max(u_xlat6.x, 0.0);
					    u_xlat0.xzw = u_xlat0.xzw * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat6.xxx + u_xlat1.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Blend One One, One One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 123684
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    vs_TEXCOORD1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    vs_TEXCOORD1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    vs_TEXCOORD1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_7;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _Color;
					    u_xlat12 = u_xlat1.w * _Color.w + (-_Cutoff);
					    u_xlatb12 = u_xlat12<0.0;
					    if(((int(u_xlatb12) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xx);
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					float u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat3.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat2 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat3.x, u_xlat2);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					bool u_xlatb3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat8;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _Color;
					    u_xlat15 = u_xlat1.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_WorldToLight[3];
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat8.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat8.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlatb3 = 0.0<u_xlat1.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat8.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat8.xy = u_xlat8.xy + vec2(0.5, 0.5);
					    u_xlat4 = texture(_LightTexture0, u_xlat8.xy);
					    u_xlat16 = u_xlat3.x * u_xlat4.w;
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = texture(_LightTextureB0, u_xlat1.xx);
					    u_xlat1.x = u_xlat16 * u_xlat3.x;
					    u_xlat15 = u_xlat15 * u_xlat1.x;
					    u_xlat1.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat5.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat1 * _Color;
					    u_xlat12 = u_xlat1.w * _Color.w + (-_Cutoff);
					    u_xlatb12 = u_xlat12<0.0;
					    if(((int(u_xlatb12) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat3 = texture(_LightTextureB0, vec2(u_xlat13));
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xyz);
					    u_xlat1.x = u_xlat1.w * u_xlat3.x;
					    u_xlat12 = u_xlat12 * u_xlat1.x;
					    u_xlat1.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					bool u_xlatb6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1 = u_xlat0 * _Color;
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_WorldToLight[3].xy;
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb6)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat9 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat6);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    }
					    u_xlat6 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat2 = texture(_LightTexture0, u_xlat0.xy);
					    u_xlat0.x = u_xlat6 * u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xxx * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    SV_Target0.w = u_xlat1.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			GpuProgramID 131646
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			ZWrite Off
			GpuProgramID 214287
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[4];
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat0.zw;
					    vs_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat1 = texture(_LightBuffer, u_xlat1.xy);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = (-u_xlat1.xyz) + vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat1 = texture(_LightBuffer, u_xlat1.xy);
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = (-u_xlat1.xyz) + vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat1 = texture(_LightBuffer, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightBuffer;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0 = u_xlat0 * _Color;
					    u_xlatb1 = u_xlat1.x<0.0;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat1 = texture(_LightBuffer, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat1.xyz + vs_TEXCOORD4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat0.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			GpuProgramID 285223
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat12 = u_xlat0.y * u_xlat0.y;
					    u_xlat12 = u_xlat0.x * u_xlat0.x + (-u_xlat12);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    vs_TEXCOORD1.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat12 = u_xlat0.y * u_xlat0.y;
					    u_xlat12 = u_xlat0.x * u_xlat0.x + (-u_xlat12);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat12) + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlatb0 = u_xlat3<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    u_xlat15 = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat3;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlatb0 = u_xlat3<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.xyz = u_xlat0.xyz * _Color.xyz;
					    u_xlat15 = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat2, u_xlat4);
					        u_xlat2.y = dot(u_xlat3, u_xlat4);
					        u_xlat2.z = dot(u_xlat1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			GpuProgramID 359260
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat8 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat3.xyz = vec3(u_xlat8) * u_xlat3.xyz;
					    u_xlat8 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat8 = (-u_xlat8) * u_xlat8 + 1.0;
					    u_xlat8 = sqrt(u_xlat8);
					    u_xlat8 = u_xlat8 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat8) + u_xlat1.xyz;
					    u_xlatb8 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb8)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat8 = unity_LightShadowBias.x / u_xlat1.w;
					    u_xlat8 = min(u_xlat8, 0.0);
					    u_xlat8 = max(u_xlat8, -1.0);
					    u_xlat8 = u_xlat8 + u_xlat1.z;
					    u_xlat12 = min(u_xlat1.w, u_xlat8);
					    gl_Position.xyw = u_xlat1.xyw;
					    u_xlat12 = (-u_xlat8) + u_xlat12;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat12 + u_xlat8;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xzw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						float _ShakeTime;
						float _ShakeWindspeed;
						float _ShakeBending;
						vec4 _MainTex_ST;
						vec4 unused_0_5;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_3_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_4_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_5_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_5_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec2 u_xlat4;
					vec2 u_xlat5;
					float u_xlat8;
					bool u_xlatb8;
					void main()
					{
					    u_xlat0 = in_POSITION0.zzzz * vec4(0.0240000002, 0.0799999982, 0.0799999982, 0.200000003);
					    u_xlat0 = in_POSITION0.xxxx * vec4(0.0480000004, 0.0599999987, 0.239999995, 0.0960000008) + u_xlat0;
					    u_xlat1.x = (-_ShakeTime) * 2.0 + 1.0;
					    u_xlat1.x = u_xlat1.x + (-in_COLOR0.z);
					    u_xlat1.x = u_xlat1.x * _Time.x;
					    u_xlat5.xy = in_COLOR0.yw + vec2(_ShakeWindspeed, _ShakeBending);
					    u_xlat1.x = u_xlat5.x * u_xlat1.x;
					    u_xlat5.x = u_xlat5.y * in_TEXCOORD0.y;
					    u_xlat0 = u_xlat1.xxxx * vec4(1.20000005, 2.0, 1.60000002, 4.80000019) + u_xlat0;
					    u_xlat0 = fract(u_xlat0);
					    u_xlat0 = u_xlat0 * vec4(6.40884876, 6.40884876, 6.40884876, 6.40884876) + vec4(-3.14159274, -3.14159274, -3.14159274, -3.14159274);
					    u_xlat2 = u_xlat0 * u_xlat0;
					    u_xlat3 = u_xlat0 * u_xlat2;
					    u_xlat0 = u_xlat3 * vec4(-0.161616161, -0.161616161, -0.161616161, -0.161616161) + u_xlat0;
					    u_xlat3 = u_xlat2 * u_xlat3;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat0 = u_xlat3 * vec4(0.00833330024, 0.00833330024, 0.00833330024, 0.00833330024) + u_xlat0;
					    u_xlat0 = u_xlat2 * vec4(-0.000198409994, -0.000198409994, -0.000198409994, -0.000198409994) + u_xlat0;
					    u_xlat0 = u_xlat5.xxxx * u_xlat0;
					    u_xlat0 = u_xlat0 * vec4(0.215387449, 0.358979076, 0.287183255, 0.861549795);
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat0 = u_xlat0 * u_xlat0;
					    u_xlat1.x = dot(u_xlat0, vec4(0.00600000005, 0.0199999996, -0.0199999996, 0.100000001));
					    u_xlat0.x = dot(u_xlat0, vec4(0.0240000002, 0.0399999991, -0.119999997, 0.0960000008));
					    u_xlat4.xy = u_xlat1.xx * unity_WorldToObject[2].xz;
					    u_xlat0.xy = unity_WorldToObject[0].xz * u_xlat0.xx + u_xlat4.xy;
					    u_xlat0.xy = (-u_xlat0.xy) + in_POSITION0.xz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * u_xlat0.yyyy + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat8 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat3.xyz = vec3(u_xlat8) * u_xlat3.xyz;
					    u_xlat8 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat8 = (-u_xlat8) * u_xlat8 + 1.0;
					    u_xlat8 = sqrt(u_xlat8);
					    u_xlat8 = u_xlat8 * unity_LightShadowBias.z;
					    u_xlat2.xyz = (-u_xlat3.xyz) * vec3(u_xlat8) + u_xlat1.xyz;
					    u_xlatb8 = unity_LightShadowBias.z!=0.0;
					    u_xlat1.xyz = (bool(u_xlatb8)) ? u_xlat2.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat8 = min(u_xlat1.w, u_xlat1.z);
					    u_xlat8 = (-u_xlat1.z) + u_xlat8;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat8 + u_xlat1.z;
					    gl_Position.xyw = u_xlat1.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xzw = unity_ObjectToWorld[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * u_xlat0.yyy + u_xlat0.xzw;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD1.xy);
					    u_xlat0.x = u_xlat0.w * _Color.w + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Transparent/Cutout/VertexLit"
}