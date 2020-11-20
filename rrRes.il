
/*///////////////////////////////////////////////////////////////////////////////////////////////////

  Resistance calculator

  *** All rights reserved ***

  Author      :Reza Rezaei (reza.rezaei@amd.com)
  Version     : 1
  Date        : 11 Oct 2020
  Description : Calculate the resistanse of the selected shape of metal in the layout 

  Requires    : NA

  History :
    1.0 [10.11.20] First version is created and tested in TSMCN7 AND TSMACN5

////////////////////////////////////////////////////////////////////////////////////////////////////*/


;// defining Variables
GVAR_amdLayVariables["process"] = amdGetTechProcess()

;//defining sheet resistance value
cond(
	( !GVAR_amdLayVariables["process"]
		warn("Cannot get process information! ")
	)
/************TSMCN5********************/
	( index( GVAR_amdLayVariables["process"] "TSMC5N" )
		printf("  Process: %s detected.\n" GVAR_amdLayVariables["process"])
rsM0=0
rsM1=1
rsM2=2
rsM3=3
rsM4=4
rsM5=5
rsM6=6
rsM7=7
rsM8=8
rsM9=9
)
/************TSMCN7********************/
	( index( GVAR_amdLayVariables["process"] "TSMC7N" )
		printf("  Process: %s detected.\n" GVAR_amdLayVariables["process"])

rsM0=0
rsM1=1
rsM2=2
rsM3=3
rsM4=4
rsM5=5
rsM6=6
rsM7=7
rsM8=8
rsM9=9
)
)

;/ creating procedure to be excecuted
procedure(rrGetRes()
      shapeid=car( geGetSelectedSet( ) )
;     shapeq= dbGetq(shapeid bBox)
      shapename=shapeid~>layerName       
      shapelayernumber=shapeid~>layerNum
	    originX = car(car((shapeid~>bBox)))
    	originY = cadr(car((shapeid~>bBox)))
    	topX =  car(cadr((shapeid~>bBox)))
    	topY = cadr(cadr((shapeid~>bBox))) 
	    width = car(cadr((shapeid~>bBox))) - originX
    	height = cadr(cadr((shapeid~>bBox))) - originY
    print("***************************************************************")   
    printf("\n")   
    printf("Height is = %10.6f.\n" height)   
    printf("Width is = %10.6f.\n" width)
    printf("Layer number is = %d\n" shapelayernumber)
    printf("Layer name is %s\n" shapename)
         
when(height>width
        len=height
        span=width
    )
when(height<width
        span=height
        len=width
    )
    printf("Length is = %10.6f.\n" len)
    printf("Span is = %10.6f.\n" span)

case(shapename
                ("M0"
                    rrRes=(rsM0 * len)/span
                )
                ("M1"
                    rrRes=(rsM1 * len)/span
                )
                ("M2"
                    rrRes=(rsM2 * len)/span
                )
                ("M3"
                    rrRes=(rsM3 * len)/span
                )
                ("M4"
                    rrRes=(rsM4 * len)/span
                )
                ("M5"
                    rrRes=(rsM5 * len)/span
                )
                ("M6"
                    rrRes=(rsM6 * len)/span
                )
                ("M7"
                    rrRes=(rsM7 * len)/span
                )
                ("M8"
                    rrRes=(rsM8 * len)/span
                )
                ("M9"
                    rrRes=(rsM9 * len)/span
                )
    )

case( GVAR_amdLayVariables["process"] 
        ("TSMC5N" || "TSMC7N" 
            printf("Resistance is = %10.6f ohm .\n" rrRes)
         )
        (t
            printf("Unknown tech node \n")
        )
        (nil
            printf("Tech node not defined \n")
        )
    )
 print("***************************************************************")   

)

;/ assigning bind key to the procedure 
hiSetBindKey("Layout" "Ctrl<key>r" "rrGetRes")

;/ The end
