<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../includes/header.jsp" />

<style>
.btn.btn-secondary{
	margin: 3px;
}
</style>

	<h1>Gestion des comptes</h1>
	
	 <div class="card bootstrap w-95 mx-auto  mt-2 mb-10">
    
    	<table class="table table-striped table-bordered dataTable no-footer"  id="compte-table">
    		<thead class="bg-primary white" style="">
    			<tr>
    				<th style="width:30px" scope="col">#</th>
    				<th scope="col">ID</th>
    				<th scope="col">Role</th>
    				<th scope="col">Nom</th>
    				<th scope="col">Email</th>

    			</tr>
    		</thead>
    	</table>
    
    </div>
	</table>
<script>
var tableAccount = null


$(function(){
	tableAccount = $('#compte-table').DataTable({
		"language": { "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/French.json" },
		"ajax": {
			url:"${pageContext.request.contextPath}/admin/getAccounts",
			cache: false,
			dataSrc: ''
		},
		"aaSorting": [],
		"lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50, 100 , "Tous"]],
		"columns":[
			{"data": null, "render": function(data){
				return "";
			}},
			{"data": "idCompte"},
			{"data": "login"},
			{"data": "nomRole"},
			{"data": "email"},
		],
		responsive: true,
		dom:'Blfrtip',
		buttons:[
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
						deleteAccounts(data);
			
						
					}else{
						toastr["error"]("Vous doit supprimer au moins un Utilisateur!");
					}
					
					console.log('delete');
				}
					
			},
			{
				text: 'Mise ?? jour',
				action : (e, dt, node, config)=>{
					
				}
			},
			{
				text: 'Changer Mot de passe',
				action : (e, dt, node, config)=>{
					const count = tableAccount.rows({selected: true}).count();

					if(count != 0){
						
						let data = tableAccount.rows({selected: true}).data();
						const len = data.length;
						//startLoading();
						//var a = {0: {"idUtilisateur": 255}, 1:{"idUtilisateur": 254}};
						if(len > 2){
							toastr["error"]("Vous doit s??lectionner une seule compte!");
						}else if(len == 1){
							ChangePassword(data[0].idCompte)
						}
			
						
					}else{
						toastr["error"]("Vous doit s??lectionner au moins un Utilisateur!");
					}
				}
			},
			{
				text: 'Reset password',
				action : (e, dt, node, config)=>{
					const count = tableAccount.rows({selected: true}).count();

					if(count != 0){
						
						let data = tableAccount.rows({selected: true}).data();
						const len = data.length;
						//startLoading();
						//var a = {0: {"idUtilisateur": 255}, 1:{"idUtilisateur": 254}};
						if(len > 2){
							toastr["error"]("Vous doit s??lectionner une seule compte!");
						}else if(len == 1){
							resetPassword(data[0].idCompte)
						}
			
						
					}else{
						toastr["error"]("Vous doit s??lectionner au moins un Utilisateur!");
					}
				}
			},
			{
				text: 'Historique_Action',
				action : (e, dt, node, config)=>{
					console.log('update');
				}
			},
			{
				text: 'Historique_Connexion',
				action : (e, dt, node, config)=>{
					console.log('update');
				}
			}
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
	})
})


function ChangePassword(idCompte){
	var input = "<input id='password' class='form-control' type='text' name='password'/>"
	
	var dialog = bootbox.dialog({
		title: "Changer le role d'utilisateur",
		message: "<p>Entrez une mot de passe</p>"+input,
		size: 'small',
		onEscape: true,
		backdrop: true,
        buttons: {
        	confirm: {
                label: 'Confirmer',
                className: 'btn-success'
            },
        }
	}).on('shown.bs.modal', function(e){
		
		$(".bootbox-accept").on("click", function(){
			let pwd = $('#password').val();
			
			if(!pwd){
				toastr["error"]("pwd est vide");
				return;
			}
			
			let err = false;
			
			$.ajax({
				type: "POST",
				headers: {
					'X-CSRF-TOKEN': '${_csrf.token}',
				},
				dataType: "json",
				data: {
					"personId": idCompte,
					"password": pwd
				},
				async:false,
				url: contextPathName+"/admin/changePassword/"+pwd,
				error: (xhr)=>{
   				  if( xhr.status === 403 ) {
       					var errors = $.parseJSON(xhr.responseText);
       					swal("Error!", errors.message, "error");
       			  }else{
     		      		swal("Error!", "Something went wrong!", "error"); 
       			  }
				},
				success: (response)=>{
   					swal("succ??s!", "Le mot de passe est modifi?? avec succ??s!");
				}
				
				
			})	
		})
		
	}).init(()=>{
    	$('.bootbox').wrap('<div class="bootstrap"></div>');
    	$(".bootbox-close-button.close").css("margin","0px").css("padding","0px");
   		$(".bootbox .modal-dialog").addClass("mx-auto");
    });
}

function resetPassword(idCompte){

		
		let err = false;
		
		$.ajax({
			type: "GET",
			headers: {
				'X-CSRF-TOKEN': '${_csrf.token}',
			},
			dataType: "json",
			async:false,
			url: contextPathName+"/admin/resetPassword/"+idCompte,
			error: (xhr)=>{
  				  if( xhr.status === 403 ) {
      					var errors = $.parseJSON(xhr.responseText);
      					swal("Error!", errors.message, "error");
      			  }else{
    		      		swal("Error!", "Something went wrong!", "error"); 
      			  }
			},
			success: (response)=>{
					swal("succ??s!", "Le mot de passe est r??einitialiser succ??s! mot de pass: "+response, "success");
			}
			
			
		})	

}


</script>

<jsp:include page="../includes/footer.jsp" />