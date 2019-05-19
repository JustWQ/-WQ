using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Normap : MonoBehaviour {

    public Texture2D tex1;
    public Texture2D tex2;


	void Start () {
        for (int w = 1; w < tex1.width; w++)
        {
            for (int h = 1; h < tex2.height; h++)
            {
                float uleft = tex1.GetPixel(w - 1, h).r;
                float uright = tex1.GetPixel(w + 1, h).r;
                float u = uright - uleft;

                float vtop = tex1.GetPixel(w, h - 1).r;
                float vbottom = tex1.GetPixel(w, h + 1).r;
                float v = vbottom - vtop;

                Vector3 vector_u = new Vector3(1, 0, u);
                Vector3 vector_v = new Vector3(0, 1, v);

                Vector3 N = Vector3.Cross(vector_u, vector_v).normalized;

                float r = N.x * 0.5f + 0.5f;
                float g = N.y * 0.5f + 0.5f;
                float b = N.z * 0.5f + 0.5f;
                tex2.SetPixel(w, h, new Color(r, g, b));
            }
            tex2.Apply(false);

        }

		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
