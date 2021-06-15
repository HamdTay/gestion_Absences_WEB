<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../includes/header.jsp" />
	<div><div class="w-75 mx-auto p-3 mt-30 mb-10"><h2>Gestion de utilisteurs</h2></div></div>
    <div class='ui form w-90 bg-white'>
        <form action="${pageContext.request.contextPath}/admin/createUser" method="POST" >
            <div class="row mb-4">
                <div class="col-lg-6" >
                	<div class="row paddingPhone">
	                    <label for="fname" class="col-3">Prénom</label>
	                    <input type="text" name="prenom" class="form-control col-8" id="prenom" />
                    </div>
                </div>
                <div class="col-lg-6">
                	<div class="row paddingPhone">
                		<input type="text" class="form-control col-8" name="prenomArab" id="prenomArab" />
	                    <label for="fname_arab" class="col-3 arabText" >الاسم الشخصي</label>
	                </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-lg-6">
                	<div class="row paddingPhone">
	                    <label for="lname" class="col-3">Nom</label>
	                    <input type="text" class="form-control col-8" name="nom" id="nom"/>
	                </div>
                </div>
                <div class="col-lg-6" >
                    <div class="row paddingPhone">
                    	<input type="text" class="form-control col-8" name="nomArab" id="nomArab"/>
                    	<label for="lname_arab" class="col-3 arabText">الاسم العائلي</label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
	            <div class="col-lg-6">
	            	<div class="row paddingPhone">
	            		<label for="cin" class="col-3">CIN</label>
	                	<input type="text" name="cin" id="cin" class="form-control col-8"/>
	                </div>
	            </div>
	       	</div>
            
<!--             if user selects etudiant show a hidden cne field -->

            <div class="row mb-4">
            	<div class="col-lg-6">
            		<div class="row paddingPhone">
		                <label for="role" class="col-3">Rôle</label>
		                <select type="text" name="typePerson" id="typePerson"  onchange = "Toggle(this.value)" class="col-8 form-control">
		                    <option value="1" >Adminstrateur</option>
		                    <option value="2" >Enseignant</option>
		                    <option value="3" >Etudiant</option>
		                </select>
	            	</div>
	            </div>
            

	            <div class="col-lg-6">
	            	<div class="row paddingPhone" id="customInputSection">
		                <label for="grade" class="col-3">Grade</label>
		                <input type="text" name="grade" id="grade"  class="form-control col-8" />
	            	</div>
	            </div>
            </div>
			<div class="row mb-4">
            	<div class="col-lg-6">
            		<div class="row paddingPhone">
		                <label for="tel" class="col-3">Telephone</label>
	            		<div class="input-group col-9 p-0">
						  <div class="input-group-prepend">
						    <span class="input-group-text bg-primary white" id="telePrefix">+212</span>
						  </div>
						  <input type="tel" name="tel" id="tel" class="col-9 form-control" placeholder="677737455" aria-describedby="telePrefix" pattern="[0-9]{9}" />
						</div>
            		</div>
            	</div>
	            <div class="col-lg-6">
	            	<div class="row paddingPhone">
		                <label for="email" class="col-3">E-mail</label>
		                <input type="text" name="email" id="email" class="form-control col-8"/>
	                </div>
	            </div>
            </div>
			<input type="hidden" id ="csrf" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			       
		    <div class="form-row buttons mx-auto" >
		        <div class="ui buttons">
		            <button class="ui positive button" type="submit" id="submit">Valider</button>
		            <div class="or" data-attr="ou"></div>
		            <button class="ui button red" type="reset" id="cancel">Annuler</button>
		        </div>
		    </div>
            
        </form>
    </div>
    
    <div class="card w-95 mx-auto p-3 mt-2 mb-10">
    
    	<table class="table table-striped table-bordered dataTable no-footer"  id="utilisateur-table">
    		<thead class="bg-primary white" style="">
    			<tr>
    				<th style="width:30px" scope="col">#</th>
    				<th scope="col">ID</th>
    				<th scope="col">Type</th>
    				<th scope="col">CIN</th>
    				<th scope="col">Nom</th>
    				<th scope="col">Prénom</th>
    				<th scope="col">Email</th>
    				<th scope="col">Tele</th>
    			</tr>
    		</thead>
    	</table>
    
    </div>
<button onclick="testSwal(id)">testSwlal</button>
    <script>

    
    function changeRole(id){
        var urlInput = "<select class='form-control' id='Role_Change'><option value='' ></option><option value='1' >Adminstrateur</option><option value='2' >Enseignant</option><option value='3' >Etudiant</option>";
        urlInput+="</select>";
        bootbox.dialog({ 
            title: "Changer le role d'utilisateur",
            message: "<p>Sélectionner pour modifier</p>"+urlInput,
            size: 'medium',
            onEscape: true,
            backdrop: true,
            buttons: {
            	confirm: {
                    label: 'Confirmer',
                    className: 'btn-success'
                },
            },
            centerVertical:true,
            onHide: function(e) {
//                 history.pushState({page: 1}, "AOT Detector", "/");
            }
        }).on('shown.bs.modal', function (e) {
        	$('#Role_Change').on("change", function(){
        		console.log($(this).val());
        		let roleId = $(this).val()
        		let csrf = $("#csrf").val()
        		$.ajax({
        			type: "PUT",
        			headers: {
        				'X-CSRF-TOKEN': csrf,
        			},
        			dataType: "json",
        			async:false,
        			url: "${pageContext.request.contextPath}/admin/changeRole/"+id,
        			data: {"roleId": roleId, "id": id},
       				success: function (response) {
       					swal("succès!", "Le rôle a changé!", "success");
       					table.ajax.reload();
       				},
       				error: (xhr)=>{
       				  console.log(xhr);
       				  if( xhr.status === 403 ) {
       					var errors = $.parseJSON(xhr.responseText);
       					swal("Error!", errors.message, "error");
       				  }
       				  else{
       					swal("Error!", "Something went wrong!", "error");
       				  }              
       				},
       				complete:function(xhr){
       				  console.log(xhr);
       				}
        		})
        	})
        })
        
        
    }
    
    
    //variable for datatable
    var table = null;
    
    function deleteUsers(ids){
    	console.log("length: "+ids.length)
		swal({
		    title: "est ce-que vous avez sûr?",
		    text: "Si vous supprimez une occurence, c'est irreversible!",
		    icon: "warning",
		    buttons: true,
		    dangerMode: true,	
		}).
		then((willDelete)=>{
			if(willDelete){
				let j = 0;
				let err = false;
		        for(var i=0;i<ids.length;i++){
		            let url = "${pageContext.request.contextPath}/admin/deleteUser/"+ids[i].idUtilisateur;
	                let csrf = $("#csrf").val();
		            $.ajax({
		                headers: {
		                'X-CSRF-TOKEN': csrf
		                },
		                url: url,
		                type: "DELETE",
		                async:false,
		                dataType: 'json',
		                success: function(response){
		                    j++;
		                },
		                error: function(xhr, status ){
		                     

		                	if (status === 'error' || !xhr.responseText) {
		
		                 		 err = true;
		                 		 toastr["error"]("Utilisateur "+ ids[i].nom + ", id: "+ ids[0].idUtilisateur + " n'est pas supprimé");	       
		                    }
		                    if(xhr.status === "FORBIDDEN"){
		                 		 err = true;
		                 		 toastr["error"](xhr.message);	       	
		                    }
		                },
		                complete:function(){
		                    //stopLoading();
		                    table.ajax.reload();
		                }
		            });
		          }
	            if(!err) 
	                swal("Utilisateur supprimées!", {icon: "success"});
	            else
	                toastr["error"]("Something went wrong!");
				
			}else {
			      swal("Suppression annulée!");
			      //stopLoading();
			    }
		});
    }
    
    
    function Toggle(val){
    	$("#customInputSection").fadeOut("fast");
        switch (val) {
            case '1':
            	$("#customInputSection").html('<label for="grade" class="col-3">Grade</label> <input type="text" name="grade" id="grade"  class="form-control col-8" />');
                break;
            case '2':
            	$("#customInputSection").html('<label for="specialite" class="col-3">Spécialité</label> <input type="text" name="specialite" id="specialite"  class="form-control col-8" />');
                break;

            case '3':
            	$("#customInputSection").html('<label for="cne" class="col-3">CNE</label> <input type="text" name="cne" id="cne" class="form-control col-8"/>');
            	break;  
            default:
                break;
        }
        $("#customInputSection").fadeIn("slow");
    }


        $(function () {
			table = $('#utilisateur-table').DataTable({

				"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
				"ajax": {
					url:"${pageContext.request.contextPath}/admin/getUsers",
					cache: false,
					dataSrc: ''
				},
				"aaSorting": [],
				"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
				"columns":[
					{"data": null, "render": function(data){
						return "";
					}},
					{"data": "idUtilisateur"},
					{"data": "typePerson"},
					{"data": "cin"},
					{"data": "nom"},
					{"data": "prenom"},
					{"data": "email"},
					{"data": "telephone"},
				],
				responsive: true,
				dom:'Blfrtip',
				buttons: [
					{
						text: 'actualiser',
						action : (e, dt, node, config)=>{
							table.ajax.reload();
						}
					},
					{
						extend: 'copyHtml5',
						text: 'Copier',
						key: {
						key: 'c',
						ctrlKey: true
						}
					},
					'excelHtml5',
					{
						text: 'supprimer',
						key:{
							key:'d',
							crtlKey: true,
						}, 
						action : (e, dt, node, config)=>{
							const count = table.rows({selected: true}).count();
							
							if(count != 0){
								
								let data = table.rows({selected: true}).data();
								//const len = data.length;
								//startLoading();
								//var a = {0: {"idUtilisateur": 255}, 1:{"idUtilisateur": 254}};
								deleteUsers(data);
					
								
							}else{
								toastr["error"]("Vous doit supprimer au moins un Utilisateur!");
							}
							
							console.log('delete');
						}
							
					},
					{
						text: 'Mise à jour',
						action : (e, dt, node, config)=>{
							console.log('update');
						}
					},
					{
						text: 'Ajouter Compte',
						action : (e, dt, node, config)=>{
							//send the id to the controller, 
							//the service will retrieve the user
							//we will create the user
							//we will have to treat if the user doesn't exist or already has an account
							//with of course validation errors
							const count = table.rows({selected: true}).count();
							if(count != 0){
								
								let data = table.rows({selected: true}).data();
								
								const len = data.length;
								if(len > 1){
									toastr["error"]("Vous doit créer au maximum une seule compte!");
								}
								else{
									createAccount(data[0].idUtilisateur);	
								}        	                	
								
							}else{
								toastr["error"]("Vous doit supprimer au moins un Utilisateur!");
							}
							
							
						}
					},
					{
						text: 'Changer role',
						action : (e, dt, node, config)=>{
							
							const count = table.rows({selected: true}).count();
							if(count != 0){
								
								let data = table.rows({selected: true}).data();
								
								const len = data.length;
								if(len > 1){
									toastr["error"]("Vous doit changer le role d'un seul utilisateur!");
								}
								else if(len == 1){
									changeRole(data[0].idUtilisateur);	
								}        	                	
								
							}else{
								toastr["error"]("Vous sélectionnez un utilisateur!");
							}
							
						}
					},
					
				],        
				columnDefs: [ {
					orderable: false,
					className: 'select-checkbox',
					targets:   0,
					data: null,
					defaultContent: ''
				} ],
				select: {
					style:    false,
					selector: 'td:first-child'
				},
				order: [[ 1, 'asc' ]]
			});




//for the form

$("#submit").click((e)=>{
e.preventDefault();

let nom = $("#nom").val();
let prenom = $("#prenom").val();
let nomArab = $("#nomArab").val();
let prenomArab = $("#prenomArab").val();
let cne = $("#cne").val();
let cin = $("#cin").val();
let grade = $("#grade").val();
let specialite = $("#specialite").val();
let typeperson = $("#typePerson").val();
let telephone = $("#tel").val();
let csrf = $("#csrf").val();
let email = $("#email").val();

let err = false;

if(!nom){
	toastr["error"]("nom est vide!");
	err = true;
}
if(!prenom){
	toastr["error"]("prenom est vide!");
	err = true;
}
if(!nomArab){
	toastr["error"]("nomArab est vide!");
	err = true;
}
if(!prenomArab){
	toastr["error"]("prenomArab est vide!");
	err = true;
}
if(!cne && typeperson=="3"){
	toastr["error"]("cne est vide!");
	err = true;
}
if(!cin){
	toastr["error"]("cin est vide!");
	err = true;
	grade = "";
	specialite = "";
}
if(!grade && typeperson==1){
	toastr["error"]("grade est vide!");
	err = true;
	specialite = ""; 
	cin = "";
}
if(!specialite && typeperson==2){
	toastr["error"]("specialite est vide!");
	err = true;
	grade = "";
	cin = "";
}
if(!csrf){
	toastr["error"]("csrf est vide!");
	err = true;
}
if(!telephone){
	toastr["error"]("Telephone est vide!");
	err = true;
}

if(!err){
	$.ajax({
		type: "POST",
		headers: {
			'X-CSRF-TOKEN': csrf,
		},
		dataType: "json",
		url: "${pageContext.request.contextPath}/admin/createUser",
		data: {
			"prenom": prenom,
			"nom": nom,
			"prenomArabe":prenomArab,
			"nomArabe": nomArab,
			"cne": cne,
			"cin": cin,
			"specialite":specialite,
			"grade":grade,
			"telephone": telephone,
			"email": email,
			"typePerson": typeperson
		},
		beforeSend: ()=>{
		  $("#submit").attr("disabled","true").css("width",$("#submit").css("width")).addClass('loading');
		  $("#reset").attr("disabled","true");
		},
		success: function (response) {
			$("#reset").click();
			swal("succès!", "L'utilisateur a été ajouté!", "success");
			table.ajax.reload();
		},
		error: (xhr)=>{
		  console.log(xhr);
		  if( xhr.status === 403 ) {
			var errors = $.parseJSON(xhr.responseText);
			swal("Error!", errors.message, "error");
//                             $.each(errors, function (key, value) {
//                                 swal("Error!", value, "error");
//                             });
		  }
		  else if(xhr.status === 417){;
			  var errors = $.parseJSON(xhr.responseText);
			  const messageError = errors.message
			  const codeErr = errors.status
			  
			  let Arr = messageError.split("?");
			  
			  
//                               errors = messageError.split("?");
			  
			  const entity = Arr[0];
			  let errArr = Arr[1].split(",");
			  console.log(errArr);
			  $.each(errArr, (key, value)=>{
				  if(value){
					  toastr.error(value.split(":")[1],"ERROR: "+value.split(":")[0], { timeOut: 5000 });
				  }

			  })
			  
			  

		  }
		  else{
			swal("Error!", "Something went wrong!", "error");
		  }              
		},
		complete:function(xhr){
		  $("#submit").removeAttr("disabled").removeClass('loading');
		  $("#reset").removeAttr("disabled").removeClass('loading');
		  console.log("Hi + :" + xhr);
		}

	});
}


});
            
        });
            function showAdmin(){
                $('.input_field .grade').slideDown(500)
            }

            function showTeacher(){
                $(".hidden__input").slideUp(500);
            }
    </script>

<jsp:include page="../includes/footer.jsp" />