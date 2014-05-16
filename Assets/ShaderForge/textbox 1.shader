// Shader created with Shader Forge Beta 0.23 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.23;sub:START;pass:START;ps:lgpr:1,nrmq:1,limd:0,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:True,uamb:True,mssp:True,ufog:False,aust:False,igpj:True,qofs:0,lico:1,qpre:3,flbk:,rntp:2,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,hqsc:True,hqlp:False,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.8235294,fgcg:0.525355,fgcb:0.2058824,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|emission-2-RGB,alpha-3-OUT;n:type:ShaderForge.SFN_Color,id:2,x:33197,y:32728,ptlb:base color,c1:0.9485294,c2:0.5749248,c3:0.3138517,c4:1;n:type:ShaderForge.SFN_Slider,id:3,x:33142,y:32996,ptlb:transparency,min:0,cur:1,max:1;proporder:3-2;pass:END;sub:END;*/

Shader "Shader Forge/textbox" {
    Properties {
        _transparency ("transparency", Range(0, 1)) = 0
        _basecolor ("base color", Color) = (0.9485294,0.5749248,0.3138517,1)
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            
            
            Fog {Mode Off}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            uniform float4 _basecolor;
            uniform float _transparency;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float3 emissive = _basecolor.rgb;
                float3 finalColor = emissive;
/// Final Color:
                return fixed4(finalColor,_transparency);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
