// Shader created with Shader Forge Beta 0.23 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.23;sub:START;pass:START;ps:lgpr:1,nrmq:1,limd:0,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,uamb:True,mssp:True,ufog:True,aust:True,igpj:False,qofs:0,lico:1,qpre:1,flbk:,rntp:1,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,hqsc:True,hqlp:False,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32719,y:32712|diff-57-OUT,emission-57-OUT;n:type:ShaderForge.SFN_Color,id:2,x:33422,y:32449,ptlb:Color,c1:0.3042358,c2:0.2770329,c3:0.4485294,c4:1;n:type:ShaderForge.SFN_Tex2d,id:3,x:33422,y:32630,ptlb:Diffuse,tex:a7608c3b0de9a96438f6e082e0af95e6,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Lerp,id:57,x:33141,y:32544|A-2-RGB,B-3-RGB,T-58-OUT;n:type:ShaderForge.SFN_ValueProperty,id:58,x:33392,y:32850,ptlb:LerpValue,v1:0;proporder:2-3-58;pass:END;sub:END;*/

Shader "Shader Forge/ManTrany" {
    Properties {
        _Color ("Color", Color) = (0.3042358,0.2770329,0.4485294,1)
        _Diffuse ("Diffuse", 2D) = "white" {}
        _LerpValue ("LerpValue", Float ) = 0
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            uniform float4 _Color;
            uniform sampler2D _Diffuse; uniform float4 _Diffuse_ST;
            uniform float _LerpValue;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float2 node_79 = i.uv0;
                float3 node_57 = lerp(_Color.rgb,tex2D(_Diffuse,TRANSFORM_TEX(node_79.rg, _Diffuse)).rgb,_LerpValue);
                float3 emissive = node_57;
                float3 finalColor = emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
