<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../includes/header.jsp" />

    <div class='ui form bordered w-50' style="width:75%">
        <h1 class="title">Login</h1>
        <form action="${pageContext.request.contextPath}/admin/createUser" method="POST" >
            <div class="names">
                <div class="input_field" >
                    <label for="fname"style="width: 54px;margin-right: 10px;">Preom</label>
                    <input type="text" name="prenom" id="prenom" required/>
                </div>
                <div class="input_field input_field_ar">
                    <label for="fname_arab" style="width: 110px;direction: rtl;" >الاسم الشخصي</label>
                    <input type="text" name="prenomArab" id="prenomArab" required/>
                </div>
            </div>
            <div class="names left">
                <div class="input_field">
                    <label for="lname" style="width: 54px;margin-right: 10px;">nom</label>
                    <input type="text" name="nom" id="nom"required/>
                </div>
                <div class="input_field input_field_ar" >
                    <label for="lname_arab" style="width: 110px;direction: rtl;">الاسم العائلي</label>
                    <input type="text" name="nomArab" id="nomArab"/>
                </div>
            </div>
            <div class="input_field">
                <label for="cin">CIN</label>
                <input type="text" name="cin" id="cin"   class="input___145"/>
            </div>
            <div class="input_field">
                <label for="email">E-mail</label>
                <input type="text" name="email" id="email"   class="input___145"/>
            </div>
            
<!--             if user selects etudiant show a hidden cne field -->

            <div class="input_field">
                <label for="role">Rôle</label>
                <select type="text" name="typePerson" id="typePerson"  onclick = "Toggle(this.value)" class="input___145">
                    <option value="1" >Adminstrateur</option>
                    <option value="2" >Enseignant</option>
                    <option value="3" >Etudiant</option>
                </select>
            </div>

            <div class="input_field hidden__input"  style="display:none">
                <label for="cne">CNE</label>
                <input type="text" name="cne" id="cne"   class="input___145"/>
            </div>

<!--             <div class="input_field hidden__input"   style="display:none"  > -->
<!--                 <label for="niveau" >Niveau</label> -->
<!--                 <input type="text" name="niveau" id="niveau"  class="input___145" /> -->
<!--             </div> -->


			

            <div class="input_field grade" >
                <label for="grade" >Grade</label>
                <input type="text" name="grade" id="grade"  class="input___145" />
            </div>


            <div class="input_field specialite" style="display:none" >
                <label for="specialite" >Spécialité</label>
                <input type="text" name="specialite" id="specialite"  class="input___145" />
            </div>
			<input type="hidden" id ="csrf" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div class="input_field">
                <label for="tel">Telephone +212</label>
                <input type="tel" name="tel" id="tel"  placeholder="600550055" pattern="[0-9]{9}" style=" width: calc(100% - 145px); "/>
            </div>


            
    <div class="form-row buttons" >
        <div class="ui buttons mx-auto">
            <button class="ui positive button" type="submit" id="submit">valider</button>
            <div class="or" data-attr="ou"></div>
            <button class="ui button red" type="cancel" id="reset">Annuler</button>
        </div>
    </div>
            
        </form>
    </div>
    
    <div class="card w-95 mx-auto p-3 mt-2 mb-10">
    
    	<table class="table table-striped table-bordered dataTable no-foote mt-5" style="padding-top:50px"  id="utilisateur-table">
    		<thead class="bg-primary" style="">
    			<tr>
    				<th style="width:30px" scope="col">#</th>
    				<th scope="col">Id</th>
    				<th scope="col">Type</th>
    				<th scope="col">CIN</th>
    				<th scope="col">Nom</th>
    				<th scope="col">Prenom</th>
    				<th scope="col">Email</th>
    				<th scope="col">Tele</th>
    			</tr>
    			
    		</thead>

    	</table>
    
    </div>

    <script>
    
    
    //variable for datatable
    var table = null;
    
    function deleteUsers(ids){
    	console.log(ids)
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
			                     console.log(response);
		                 		 err = true;
		                 		 toastr["error"]("Utilisateur "+ ids[i].nom + ", id: "+ ids[0].idUtilisateur + " n'est pas supprimé");	       
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
    	console.log("inside Toggle: " + val)
        switch (val) {
            case '1':
                $('.grade').slideDown(500)
                $(".hidden__input").slideUp(500);
                $('#grade').hide()
                $('#cne').val("");
                $('#specialite').val("");
                break;
            case '2':
                $('.specialite').slideDown(500)
                $(".hidden__input").slideUp(500);
                $('.grade').hide();
                $('#cne').val("");
                $('#grade').val("");
                break;

            case '3':
                $('.grade').hide()
                $('.specialite').hide()
                $('.hidden__input').slideDown(500)
                $('#specialite').val("");
                $('#grade').val("");
                break;            
            
            default:
                break;
        }
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
         	                console.log('update');
         	            }
        	         },
        	         {
        	        	 text: 'Changer role',
        	        	 action : (e, dt, node, config)=>{
         	                console.log('update');
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
                }
                if(!grade && typeperson==1){
                    toastr["error"]("grade est vide!");
                    err = true;
                }
                if(!specialite && typeperson==2){
                    toastr["error"]("specialite est vide!");
                    err = true;
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
                            swal("succès!", "Le stage a été ajouté!", "success");
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
                            		  //toastr["error"], { timeOut: 20000 });
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
                console.log('is it working admin')
                $('.input_field .grade').slideDown(500)
            }

            function showTeacher(){
                $(".hidden__input").slideUp(500);
            }



        


    </script>

<jsp:include page="../includes/footer.jsp" />