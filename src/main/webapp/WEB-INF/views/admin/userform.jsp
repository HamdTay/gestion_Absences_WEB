
<jsp:include page="../includes/header.jsp" />

    <div class='form'>
        <h1 class="title">Login</h1>
        <form action="${pageContext.request.contextPath}/createUser" method="POST" >
            <div class="names">
                <div class="input_field" >
                    <label for="fname"style="width: 54px;margin-right: 10px;">Preom</label>
                    <input type="text" name="prenom" id="prenom" required/>
                </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
<br>
            <div class="input_field">
                <label for="email">E-mail</label>
                <input type="text" name="email" id="email"   class="input___145"/>
            </div>
            
<!--             if user selects etudiant show a hidden cne field -->

            <div class="input_field">
                <label for="role">Rôle</label>
                <select type="text" name="typePerson" id="role"  onclick = "Toggle(this.value)" class="input___145">
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

            <div class="buttons">
                <div class="submit">
                    <input type="submit" id="submit" value="valider">
                </div>
                <div class="reset">
                    <input type="reset" id="reset" value="annuler">
                </div>
            </div>
        </form>
    </div>


    <script>


        $(function () {
            
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
                let typeperson = $("#typePerson");

                let csrf = $("#csrf").val();

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
                if(!grade && typepreson==1){
                    toastr["error"]("grade est vide!");
                    err = true;
                }
                if(!specialite && typepreson==2){
                    toastr["error"]("specialite est vide!");
                    err = true;
                }
                if(!csrf){
                    toastr["error"]("csrf est vide!");
                    err = true;
                }

                if(!err){
                    $.$.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        url: "url",
                        data: {
                            prenom: prenom,
                            nom: nom,
                            prenomArab:prenomArab,
                            nomArab: nomArab,
                            cne: cne,
                            cin: cin,
                            specialite:specialite,
                            grade:grade,
                            csrf: csrf
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
                          if( xhr.status === 422 ) {
                            var errors = $.parseJSON(xhr.responseText);
                            $.each(errors, function (key, value) {
                                swal("Error!", value, "error");
                            });
                          }
                          else{
                            swal("Error!", "Something went wrong!", "error");
                          }              
                        },
                        complete:function(){
                          $("#submit").removeAttr("disabled").removeClass('loading');
                          $("reset").removeAttr("disabled").removeClass('loading');
                        }

                    });
                }


            })
        });


            function showAdmin(){
                console.log('is it working admin')
                $('.input_field .grade').slideDown(500)
            }

            function showTeacher(){
                $(".hidden__input").slideUp(500);
            }

        function Toggle(val){
            switch (val) {
                case 'adminstrateur':
                    $('.grade').slideDown(500)
                    $(".hidden__input").slideUp(500);
                    $('.specialite').hide()
                    break;
                case 'enseignant':
                    $('.specialite').slideDown(500)
                    $(".hidden__input").slideUp(500);
                    $('.grade').hide()
                    break;

                case 'Etudiant':
                    $('.grade').hide()
                    $('.specialite').hide()
                    $('.hidden__input').slideDown(500)
                    break;            
                
                default:
                    break;
            }
        }

        


    </script>

<jsp:include page="../includes/footer.jsp" />