using UnityEngine;
using System.Collections;

public class ColorFade : MonoBehaviour {

	public float lerpRate;

	// Use this for initialization
	void Start ()
	{
	
	}
	
	// Update is called once per frame
	void Update ()
	{
	if(Input.GetKeyDown(KeyCode.F))
		{
			StartCoroutine("LerpMaterial");
		}
	}

	public IEnumerator LerpMaterial()
	{
		float value = transform.renderer.material.GetFloat("_LerpValue");
		while(value < 1)
		{
			value += lerpRate;
			transform.renderer.material.SetFloat("_LerpValue", value);
			yield return new WaitForSeconds(.5f);
		}
	}
}
