using UnityEngine;
using System.Collections;
using Vectrosity;




public class line : MonoBehaviour {

	public Vector2[] curvePoints;	// The points for the curve are defined in the inspector
	public int segments = 3;
	public Material lineMaterial;
	// Use this for initialization
	void Start () {
		//VectorLine.SetLine (Color.green, new Vector2(0, 0), new Vector2(Screen.width-1, Screen.height-1));
		if (curvePoints.Length != 4) {
			Debug.Log ("Curve points array must have 4 elements only");
			return;
		}
		
		// Make Vector2 array where the size is the number of segments plus one, since it's for a continuous line
		// (A discrete line would need the size to be segments*2)
		Vector2[] linePoints = new Vector2[segments+1];
		
		// Make a VectorLine object using the above points and the default material,
		// with a width of 2 pixels, an end cap of 0 pixels, and depth 0
		VectorLine line = new VectorLine("Curve", linePoints, Color.white, lineMaterial, 2.0f, LineType.Continuous, Joins.Weld);
		// Create a curve in the VectorLine object using the curvePoints array as defined in the inspector
		line.MakeCurve (curvePoints, segments);
		
		// Draw the line
		line.Draw();

	}
	
	// Update is called once per frame
	void Update () {
	
	}
}

