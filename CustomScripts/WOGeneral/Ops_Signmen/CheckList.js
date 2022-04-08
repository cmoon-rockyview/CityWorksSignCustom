var _chkBoxes = [];
var _chkNumArray = [];
var _chkNumText = "";

// Use multiple javascript file;
//https://www.youtube.com/watch?v=11c7JqM2vRc


$(function () {


    console.log("test");
									
    var assetNo = $("#ctl00_Main_ctl144").val();
    var TPNo = assetNo.substring(0,assetNo.indexOf("S"));						
    $("#ctl00_Main_ctl144").attr("readonly", true);
    $("#ctl00_Main_ctl149").attr("readonly", true);
    
    $("#ctl00_Main_ctl144").addClass("input-disabled");
    
    $("#ctl00_Main_ctl144").click(function(){ 
    
        window.open("http://ams/MaintRepo/Operations/SignPictures/TP" + TPNo + "/" + assetNo + ".jpg");
    
    });      



     function addCheckbox(id, name, container, appWay) {

        var chk = $('<input  />', {
            type: 'checkbox', id: 'cb' + id, value: name, class: "chkPoints"
            , style: "margin-left:25px"
        });

        container.after(chk);

        var lbl = $('<label />', { 'for': 'cb' + id, text: name, style: "font-color:blue; font-weight:bold; font-size:12pt;" });

        chk.after(lbl);
        _chkBoxes.push(chk);
        return lbl;
    }    

    var chkContainer0 = $("#ctl00_Main_check0");

    var container1 = addCheckbox("1", "Temporary Sign", chkContainer0, "before");
    var container2 = addCheckbox("2", "Auger", container1);

    //Temporary Sign
    if ($("#ctl00_Main_ctl158").val() == "Temporary"){

        $("#cb1").prop("checked", true);
    }

    //Auger
    if ($("#ctl00_Main_ctl163").val() == "Auger"){

        $("#cb2").prop("checked", true);
    }

    //Temporary Sign
    $("#cb1").change(()=>{
        
        var bCheck = $("#cb1").prop("checked") ? "Temporary": "";

        $("#ctl00_Main_ctl158").val(bCheck);       
        

    })

    //Auger
    $("#cb2").change(()=>{

        var bCheck = $("#cb2").prop("checked") ? "Auger": "";

        $("#ctl00_Main_ctl163").val(bCheck);
        
    })


});           