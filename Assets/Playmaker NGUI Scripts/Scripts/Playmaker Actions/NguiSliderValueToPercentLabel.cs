using HutongGames.PlayMaker;

/*
 * *************************************************************************************
 * Created by: Rocket Games Mobile  (http://www.rocketgamesmobile.com), 2013-2014
 * For use in Unity 3.5, Unity 4.0+
 * 
 * Updated for NGUI v3
 * *************************************************************************************
*/

[ActionCategory("NGUI")]
[Tooltip("Displays the value from a slider or progressbar in an NGUI Label, as a percent")]
public class NguiSliderValueToPercentLabel : FsmStateAction
{
    [RequiredField]
    [Tooltip("NGUI slider or progressbar")]
    public FsmOwnerDefault NguiSlider;

    [RequiredField]
    [Tooltip("NGUI label used to display the value")]
    public FsmGameObject NguiLabel;

    [UIHint(UIHint.Variable)]
    [Tooltip("Variable to store the slider's value")]
    public FsmFloat storeValue;

    [Tooltip("When true, runs on every frame")]
    public bool everyFrame;

    public override void Reset()
    {
        NguiSlider = null;
        NguiLabel = null;
        storeValue = null;
        everyFrame = false;
    }

    public override void OnEnter()
    {
        DoReadSlider();

        if (!everyFrame)
            Finish();
    }

    public override void OnUpdate()
    {
        DoReadSlider();
    }

    private void DoReadSlider()
    {
        // exit if objects are null
        if ((NguiLabel == null) || (NguiSlider == null))
            return;

        // get the slider as a GO
        UISlider NSlider = Fsm.GetOwnerDefaultTarget(NguiSlider).GetComponent<UISlider>();

        // get the label as a GO
        UILabel NLabel = NguiLabel.Value.GetComponent<UILabel>();

        // exit if there is no NGUI label or slider on it
        if ((NSlider == null) || (NLabel == null))
            return;

        // set the label text
        NLabel.text = string.Format("{0:P}", NSlider.value);

        // save the value
        if (storeValue != null)
            storeValue.Value = NSlider.value;
    }
}