Shader "Unlit/CubeFaceColor"
{
    Properties
    {
        _FrontColor ("Front (Z+)", Color) = (0, 1, 1, 1)
        _BackColor ("Back (Z-)", Color) = (1, 0, 1, 1)
        _LeftColor ("Left (X-)", Color) = (0, 1, 0, 1)
        _RightColor ("Right (X+)", Color) = (1, 0, 0, 1)
        _UpColor ("Up (Y+)", Color) = (0, 0, 1, 1)
        _DownColor ("Down (Y-)", Color) = (1, 1, 0, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            fixed4 _FrontColor, _BackColor, _LeftColor, _RightColor, _UpColor, _DownColor;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL; // Normal in local coordinates
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 localNormal : TEXCOORD0; // Pass the local normal
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.localNormal = v.normal; // Important: use local normal!
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Define the edge by the local normal (does not depend on rotation)
                float3 absNormal = abs(i.localNormal);

                if (absNormal.x > absNormal.y && absNormal.x > absNormal.z)
                    return (i.localNormal.x > 0) ? _RightColor : _LeftColor;
                else if (absNormal.y > absNormal.z)
                    return (i.localNormal.y > 0) ? _UpColor : _DownColor;
                else
                    return (i.localNormal.z > 0) ? _FrontColor : _BackColor;
            }
            ENDCG
        }
    }
}
