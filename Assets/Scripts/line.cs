using UnityEngine;
using System;
using Vectrosity;
using System.Collections;

public class line : MonoBehaviour {
	//Vector3[] curvePoints;	// The points for the curve are defined in the inspector
	//public int segments = 3;
	public Material lineMaterial;
	//ctor2 targetPosition;
	//Vector3 targetVector;
	public GameObject TargetObject;
	public GameObject ButtonObject;
	private Vector3 targetPosition;
	private Vector3 buttonPosition;
	private Vector3 middlePositionTarget;
	private Vector3 middlePositionButton;
	private VectorLine myLine;
	private Vector3[] linePoints;
	public int drawSpeed = 1;
	private Vector3[] curvePoints;
	public int segments = 100;
	public int stopBuffer = 1;
	public bool isActive = false;
	public bool isDrawn = false;



	// Use this for initialization

	void Start () {
		curvePoints = new Vector3[4];
		TargetObject = gameObject.transform.Find("target").gameObject;
		ButtonObject = gameObject;
		targetPosition = TargetObject.transform.position;
		buttonPosition = ButtonObject.transform.position;
		middlePositionButton = new Vector3(buttonPosition.x, targetPosition.y, buttonPosition.z);
		middlePositionTarget = new Vector3(targetPosition.x, buttonPosition.y, targetPosition.z);

		linePoints = new Vector3[segments+1];
		myLine = new VectorLine("MyLine", linePoints, lineMaterial, 2.0f, LineType.Continuous, Joins.Weld);
		//myLine = new VectorLine("MyLine", linePoints, lineMaterial, 2.0f, LineType.Continuous, Joins.Fill);
		//Vector2 targetPosition = Camera.WorldToScreenPoint(transform.FindChild("target").position);
		//Vector3 targetVector = targetPosition.transform.position;
		//Debug.Log (targetPosition.transform.position.x);
		//curvePoints = new Vector3[4];
		Debug.Log ("Target Position: " + targetPosition);
		Debug.Log ("Middle Button Position: " + middlePositionButton);
		Debug.Log ("Middle Target Position: " + middlePositionTarget);
		Debug.Log ("Button Position: " + buttonPosition);
		myLine.textureScale = 4.0f;
		myLine.drawStart = 0;
		myLine.drawEnd = 0;


	}
	
	// Update is called once per frame
	void Update () {


			Debug.Log ("Active");
			targetPosition = TargetObject.transform.position;
			buttonPosition = ButtonObject.transform.position;
			middlePositionButton = new Vector3(buttonPosition.x, targetPosition.y, buttonPosition.z);
			middlePositionTarget = new Vector3(targetPosition.x, buttonPosition.y, targetPosition.z);
			//Debug.Log ("Target Position: " + targetPosition);

			curvePoints[0] = targetPosition;

			curvePoints[1] = middlePositionTarget;
			curvePoints[2] = buttonPosition;

			curvePoints[3] = middlePositionButton;

			myLine.MakeCurve (curvePoints, segments);

		if (isActive != false){

			myLine.drawStart = 0;
			if (myLine.drawEnd < segments - stopBuffer) {
				myLine.drawEnd = myLine.drawEnd + drawSpeed;
			} else {
				isDrawn = true;
			}

	
		}else{
			myLine.drawEnd = 0;
		}

			myLine.Draw();

	}

}


