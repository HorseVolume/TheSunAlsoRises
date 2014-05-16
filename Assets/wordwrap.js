// Word Wrap v1.0 for Unity 3D Text Objects

// 

// Author: Michael Colin Voigt

// [url]http://3037.com[/url]

// Free for all purposes, if you use it, just email me at [email]info@3037.com[/email]

 

public var textObject:GameObject;

public var wrapPoint = 0;

public var currentText:String;

public var hyphen = true;

 

function Awake () 

{

 

    currentText = " " + currentText;

    

    var finalString:String ="";

 

    var currentWrap = wrapPoint;

    var count = 0;

    var startPoint = 0;

    var lastBlankSpace = 0;

    var currentLength = 0;

    var appendText:String = "";

 

    while( count <= currentText.Length  )

    {

 

        count++;

    

        if( count   >= currentText.Length)

        {

                var finalLength = currentText.Length - startPoint;

                finalString +=  currentText.Substring( startPoint+1 , finalLength-1 );

                break;

        }

    

        if( currentText[count] == " " )

        {

            lastBlankSpace = count;

        }

    

        if( currentText[count] == " " && count >= currentWrap )

        {

    

            currentLength = count - startPoint;

        

            appendText = currentText.Substring( startPoint+1 , currentLength ) + "\n" ;

            finalString += appendText;

        

            currentWrap = count + wrapPoint;

            startPoint = count;

    

        }

        

        if( currentText[count] != " " && count >= currentWrap )

        {

            

            for(var i = count; i > startPoint;i--)

            {

                

                

                if( currentText[i] == " " ) 

                {

                    

                    

                Debug.Log(currentText[i]);

                    

                    currentLength = i - startPoint;

        

                    appendText = currentText.Substring( startPoint+1 , currentLength ) + "\n" ;

                    finalString += appendText;

        

                    currentWrap = i + wrapPoint;

                    startPoint = i;

    

                }

                

            }

        }

        

        

        if(hyphen)

        {

            var worldLength = (count - lastBlankSpace);

    

            if(  worldLength  >    wrapPoint )

            {

                currentLength = count - startPoint;

        

                appendText = currentText.Substring( startPoint+1 , currentLength ) + "-\n" ;

                finalString += appendText;

        

                currentWrap = count + wrapPoint;

                startPoint = count; 

                lastBlankSpace = count; 

            }

        }

    }

 

textObject.GetComponent (TextMesh).text = finalString;

 

}