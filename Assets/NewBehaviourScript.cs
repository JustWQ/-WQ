using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NewBehaviourScript : MonoBehaviour {

	// Use this for initialization
	void Start () {
        GetComponent<Renderer>().material.SetVector("_Color2", new Vector4(1, 0, 0, 1));
	}
	
	// Update is called once per frame
	void Update () {
        Matrix4x4 mvp = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix ;//pvm,因为unity乘法的处理方式，这里要做一个颠倒

      

        GetComponent<Renderer>().material.SetMatrix("mvp", mvp);


	}
}
