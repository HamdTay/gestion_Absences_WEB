<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300&display=swap" rel="stylesheet">
    <!-- Icon -->

      <!-- Icon -->
        <link rel="icon" type="image/png" href="<c:url value="resources/images/icon.png" />"/>
        <title> ENSAH - Absence </title>
        <!-- CSS Bootstrap -->
        <link href="<c:url value="/resources/css/bootstrap.min.css" />" rel="stylesheet">       
        <!-- JSBootstrap -->
        <script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>    
        <!-- CSS Semantic UI -->
        <link href="<c:url value="/resources/assets/semanticUI/semantic.css" />" rel="stylesheet">
        <!-- JS Semantic UI -->
        <script href="<c:url value="/resources/assets/semanticUI/semantic.min.js" />"></script>
        <!-- CSS Font Awesome -->
        <link href="<c:url value="/resources/assets/font-awesome/css/all.css" />" rel="stylesheet">
        <!-- jQuery -->
        <script src="<c:url value="/resources/js/jQuery.js" />"></script>
        <!-- DataTable -->
        <link href="<c:url value="/resources/assets/datatable/datatables.min.css" />" rel="stylesheet">
        <script src="<c:url value="/resources/assets/datatable/datatables.min.js" />"></script>
        <!--Alerts -->      
            <!-- Sweet -->
        <script src="<c:url value="/resources/assets/alerts/sweet.js" />"></script>
            <!-- Bootbox -->
        <script src="<c:url value="/resources/assets/alerts/bootbox.js" />"></script>   
            <!-- Toastr -->
        <link href="<c:url value="/resources/assets/alerts/toastr.css" />" rel="stylesheet">
        <script src="<c:url value="/resources/assets/alerts/toastr.js" />"></script>
         <!-- JS Globally -->
        <script src="<c:url value="/resources/js/preglobal.js" />"></script>
        <!-- Selectize CSS -->
        <link href="<c:url value="/resources/css/selectize.css" />" rel="stylesheet"> 
        <!-- Selectize JS -->
        <script src="<c:url value="/resources/js/selectize.js" />"></script>
        <!-- Video js CSS -->
        <link href="<c:url value="/resources/css/videojs.css" />" rel="stylesheet">
        <!-- Uploader JS -->
        <script src="<c:url value="/resources/js/uploader.js" />"></script>   
        <!-- Material Icon CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/materialicons.css" />" />       
        <!-- App Pure CSS -->
        <!-- Main Pure CSS -->
        <script src="<c:url value="/resources/js/chartjs.js" />"></script>
		<link href="<c:url value="/resources/cssTeam/Omar.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/cssTeam/Tayeb.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/cssTeam/Mohcine.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/cssTeam/Amine.css" />" rel="stylesheet">
        <link href="<c:url value="/resources/cssTeam/Redouane.css" />" rel="stylesheet">
    <style>
        *{
            margin:0;
            padding:0;
            font-family: 'Cairo', sans-serif;
            box-sizing: border-box;
        }

        .form{
            max-width: 600px;
            width: 100%;
            background-color: rgb(183, 185, 163);
            margin: 30px auto;
            padding: 30px;
            box-shadow: 1px 1px 2px 1px rgba(0, 0, 0, 0.12) ;
            border-radius: 0.5em;
        }
        
        .title{
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: azure;
            text-transform: uppercase;
            text-align: center;
        }
        .names{
            display: flex;
            justify-content: space-between;
            width: 100%;
        }


        form .input_field{
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            display: flex;
            justify-content: space-between;
        }

        .input_field_ar{
            flex-direction: row-reverse;
        }
        .niveau,.date{
            display: flex;
        }
        .niveau label{
            width: 145px;
            display: flex;
        }
        .input___145{
            width: calc(100% - 145px);
        }
        .buttons {
            display: flex;
            margin-left: auto;
            margin-right: auto;
            width: fit-content;
        }
        @media only screen and (max-width: 520px) {
            .names,form .input_field,.niveau,.date{
                flex-direction: column;
            }
            .input_field label,.input_field input{width:100%!important;}
            .input___145{
                width:100%;
            }
        }
        
    </style>
    <title>Login</title>

</head>
<body>
