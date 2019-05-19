using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;
using UnityEngine.UI;

public class bowen : MonoBehaviour {

    

    Texture2D tex2d;//实例化一张新的纹理，然后通过模拟这张纹理产生波动的UV值，传给模型本身的UV值做增减（只要UV不要颜色）
    public int height=200;
    public  int width=200;
    float[,] waveA;
    float[,] waveB;
    int sleeptime;
    float time=0.08f;//按下时的间隔时间
    Color[] c; 
    // Use this for initialization
    void Start () {
        
        waveA = new float[width,height];
        waveB = new float[width, height];
        c = new Color[width*height];
        tex2d = new Texture2D(width, height);
        GetComponent<Renderer>().material.SetTexture("_WavaTex", tex2d);


        Thread th = new Thread(new ThreadStart(ComputeWave));//使用另一个线程进行波纹计算
        th.Start();
       // Putpop(width/2,height/2);
    }
    void Putpop(int x,int y)//产生一圈起始点
    {
        int radius = 5;
        float dist;
        for (int i = -radius; i <= radius; i++)
        {
            for (int j = -radius; j <= radius; j++)
            {
                if (x+i>=0&&x+i<width-1&&y+j>=0&&y+j<height-1)
                {
                    dist = Mathf.Sqrt(i * i + j * j);
                    if (dist<radius)
                    {
                        waveA[x + i, y + j] = Mathf.Cos(dist*Mathf.PI/radius);
                        


                    }
                }
            }
        }

    }
	// Update is called once per frame
	void Update () {
        sleeptime = (int)(Time.deltaTime*1000);
        tex2d.SetPixels(c);
        tex2d.Apply();
        time -= Time.deltaTime;//用作按下鼠标时的时间间隔
        if (Input.GetMouseButton(0)&&time<0)
        {
            time = 0.04f;
            RaycastHit hit = new RaycastHit();
            Ray r = Camera.main.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(r,out hit))
            {
                Vector3 v = hit.point;
                v = transform.worldToLocalMatrix.MultiplyPoint(v);
                //Debug.Log(v);
                int w = (int)((1-v.x - 0.5) * width);
                int h = (int)((v.y + 0.5) * height);

                Putpop(w, h);

            }


        }



	}
    void ComputeWave()
    {
        while (true)
        {
            for (int i = 1; i < width - 1; i++)
            {
                for (int j = 1; j < height - 1; j++)
                {
                    waveB[i, j] = (waveA[i - 1, j] +
                        waveA[i + 1, j] +
                        waveA[i + 1, j + 1] +
                        waveA[i + 1, j - 1] +
                        waveA[i - 1, j + 1] +
                        waveA[i, j + 1] +
                        waveA[i, j - 1] +
                        waveA[i - 1, j - 1]) / 4 - waveB[i, j];
                    if (waveB[i, j] < -1)
                    {
                        waveB[i, j] = -1;
                    }
                    if (waveB[i, j] > 1)
                    {
                        waveB[i, j] = 1;
                    }

                    float offset_u = (waveB[i - 1, j] - waveB[i + 1, j]) / 2;
                    float offset_v = (waveB[i, j - 1] - waveB[i, j + 1]) / 2;

                    float r = offset_u / 2 + 0.5f;
                    float g = offset_v / 2 + 0.5f;

                    //tex2d.SetPixel(i, j, new Color(r, g, 1));
                    c[i + width * j] = new Color(r, g, 0);
                    waveB[i, j] -= waveB[i, j] * 0.008f;

                }
            }
            // tex2d.Apply();

            float[,] temp = waveB;
            waveB = waveA;
            waveA = temp;
            Thread.Sleep(sleeptime);//sleeptime是通过update获取的每一帧的时间间隔
        }
    }
}
