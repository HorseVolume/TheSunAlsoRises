// Shader created with Shader Forge Beta 0.23 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.23;sub:START;pass:START;ps:lgpr:1,nrmq:1,limd:1,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,uamb:True,mssp:True,ufog:True,aust:True,igpj:False,qofs:0,lico:1,qpre:1,flbk:,rntp:1,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,hqsc:True,hqlp:False,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.8235294,fgcg:0.525355,fgcb:0.2058824,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32705,y:32641|diff-427-OUT,diffpow-668-OUT,emission-659-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33444,y:32617,ptlb:node_2,tex:a7608c3b0de9a96438f6e082e0af95e6,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:427,x:33032,y:32462|A-2-RGB,B-550-OUT,T-428-OUT;n:type:ShaderForge.SFN_Slider,id:428,x:33332,y:32510,ptlb:Lerp Blend,min:0,cur:0.3760913,max:1;n:type:ShaderForge.SFN_Slider,id:440,x:33264,y:33064,ptlb:Emissive Lerp,min:0,cur:0.5413534,max:1;n:type:ShaderForge.SFN_LightColor,id:494,x:33414,y:32006;n:type:ShaderForge.SFN_Lerp,id:550,x:33073,y:32014|A-494-RGB,B-551-RGB,T-552-OUT;n:type:ShaderForge.SFN_Color,id:551,x:33419,y:32183,ptlb:Light Mixin,c1:1,c2:0.6,c3:0,c4:1;n:type:ShaderForge.SFN_Slider,id:552,x:33363,y:32359,ptlb:Natural Light Blend,min:0,cur:0.6527411,max:1;n:type:ShaderForge.SFN_Color,id:558,x:33500,y:32817,ptlb:Emissive Dropout Color,c1:0.2426471,c2:0.1623225,c3:0.06066176,c4:1;n:type:ShaderForge.SFN_Lerp,id:659,x:33139,y:32786|A-2-RGB,B-558-RGB,T-440-OUT;n:type:ShaderForge.SFN_Slider,id:668,x:33025,y:32663,ptlb:node_668,min:0,cur:0.7518802,max:1;proporder:2-428-440-551-552-558-668;pass:END;sub:END;*/

Shader "Shader Forge/toonmedic" {
    Properties {
        _node2 ("node_2", 2D) = "white" {}
        _LerpBlend ("Lerp Blend", Range(0, 1)) = 0
        _EmissiveLerp ("Emissive Lerp", Range(0, 1)) = 0
        _LightMixin ("Light Mixin", Color) = (1,0.6,0,1)
        _NaturalLightBlend ("Natural Light Blend", Range(0, 1)) = 0
        _EmissiveDropoutColor ("Emissive Dropout Color", Color) = (0.2426471,0.1623225,0.06066176,1)
        _node668 ("node_668", Range(0, 1)) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _node2; uniform float4 _node2_ST;
            uniform float _LerpBlend;
            uniform float _EmissiveLerp;
            uniform float4 _LightMixin;
            uniform float _NaturalLightBlend;
            uniform float4 _EmissiveDropoutColor;
            uniform float _node668;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), _node668) * attenColor + UNITY_LIGHTMODEL_AMBIENT.xyz;
////// Emissive:
                float2 node_676 = i.uv0;
                float4 node_2 = tex2D(_node2,TRANSFORM_TEX(node_676.rg, _node2));
                float3 emissive = lerp(node_2.rgb,_EmissiveDropoutColor.rgb,_EmissiveLerp);
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * lerp(node_2.rgb,lerp(_LightColor0.rgb,_LightMixin.rgb,_NaturalLightBlend),_LerpBlend);
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _node2; uniform float4 _node2_ST;
            uniform float _LerpBlend;
            uniform float _EmissiveLerp;
            uniform float4 _LightMixin;
            uniform float _NaturalLightBlend;
            uniform float4 _EmissiveDropoutColor;
            uniform float _node668;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = pow(max( 0.0, NdotL), _node668) * attenColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                float2 node_677 = i.uv0;
                float4 node_2 = tex2D(_node2,TRANSFORM_TEX(node_677.rg, _node2));
                finalColor += diffuseLight * lerp(node_2.rgb,lerp(_LightColor0.rgb,_LightMixin.rgb,_NaturalLightBlend),_LerpBlend);
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
