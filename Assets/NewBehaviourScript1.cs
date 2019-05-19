using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript1 : MonoBehaviour {

    bool index=true;
    float time =1;
    public float max = 8f;//变换最高值
    public float min = 1f;//变化最低值
    public  float T=2;//周期


    void Update () {

        if (T<0)
        {
            T = 1;
        }
        if (T>4)
        {
            T = 4;
        }

        float speed = (max - min) / T;
        time = time - Time.deltaTime;
        if (time<0)
        {
            time = T;
            index = !index;
        }
        if (index)
        {
            GetComponent<Renderer>().material.SetFloat("_sint", min + speed * time);
        }
        else
        {
            GetComponent<Renderer>().material.SetFloat("_sint", max - speed * time);
        }
        //Debug.Log(time);
    }
}
