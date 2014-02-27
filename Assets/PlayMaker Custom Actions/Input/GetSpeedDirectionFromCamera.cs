// (c) Copyright HutongGames, LLC 2010-2013. All rights reserved.

using UnityEngine;

namespace HutongGames.PlayMaker.Actions
{
	[ActionCategory(ActionCategory.Camera)]
	[Tooltip("Convert input to worldspace ( based in main camera) and to Speed and Direction")]
	public class GetCameraBasedSpeedDirection : FsmStateAction
	{

		[RequiredField]
		[Tooltip("The Horizontal input")]
		public FsmFloat horizontalInput;

		[RequiredField]
		[Tooltip("The Vertical input")]
		public FsmFloat verticalInput;

		[Tooltip("Repeat every frame. Useful when value is subject to change over time.")]
		public bool everyFrame;
		
		[ActionSection("Results")]

		[UIHint(UIHint.Variable)]
		[Tooltip("The input values as worldspace coordinates")]
		public FsmVector3 worldSpaceInput;

		[Tooltip("The target to express speed and direction from")]
		public FsmOwnerDefault target;

		[UIHint(UIHint.Variable)]
		public FsmFloat speed;

		[UIHint(UIHint.Variable)]
		public FsmFloat direction;


		Transform _target;
		Vector3 _directionWS;

		public override void Reset()
		{
			horizontalInput = null;
			verticalInput = null;
			worldSpaceInput = null;
			speed = null;
			direction = null;
			everyFrame = false;
		}
		
		public override void OnEnter()
		{

			GameObject _go = Fsm.GetOwnerDefaultTarget(target);
			
			if (_go!=null)
			{
				_target = _go.transform;
			}



			ConvertJoystickToWorldSpace();

			ComputeSpeedDirection();

			if (!everyFrame) 
			{
				Finish();
			}
		}

		public override void OnUpdate() 
		{
			ConvertJoystickToWorldSpace();

			ComputeSpeedDirection();
		}


		public void ConvertJoystickToWorldSpace()
		{		
			Vector3 stickDirection = new Vector3(horizontalInput.Value, 0, verticalInput.Value);                        		        

			_directionWS = Camera.main.transform.rotation * stickDirection; // Converts joystick input in Worldspace coordinates
			_directionWS.y = 0; // Kill Z
			_directionWS.Normalize();		        

			worldSpaceInput.Value = _directionWS;

		}
		
		
		public void ComputeSpeedDirection()
		{

			if (_target==null)
			{
				return;
			}

			speed.Value = Mathf.Clamp(_directionWS.magnitude, 0, 1);
			if (speed.Value > 0.01f) // dead zone
			{
				Vector3 axis = Vector3.Cross(_target.forward, _directionWS);
				direction.Value = (Vector3.Angle(_target.forward, _directionWS) * (axis.y < 0 ? -1 : 1));
			}
			else
			{
				direction.Value = 0.0f; 
			}
		} 
	}
}