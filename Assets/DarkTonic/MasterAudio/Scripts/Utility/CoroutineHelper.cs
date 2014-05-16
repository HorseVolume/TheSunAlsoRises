using UnityEngine;
using System.Collections;

public static class CoroutineHelper {
	private static readonly YieldInstruction endOfFrame = new WaitForEndOfFrame();
	
	public static IEnumerator WaitForRealSeconds(float time) {
    	var start = Time.realtimeSinceStartup;
    
		while (Time.realtimeSinceStartup < start + time) {
			yield return endOfFrame;
    	}
	}
}
