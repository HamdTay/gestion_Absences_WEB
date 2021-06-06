<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<!DOCKTYPE html>


<html>
<head>

</head>


<body>	
	<div>
		<form action="${pageContext.request.contextPath}/Authenticate" method="POST">
			
			<div>
				<label for="username">Username </label>
				<input type="text" name="user"  />
			</div>
			
			<div>
				<label for="password">Password</label>
				<input type="password" name="password"  />			
			</div>
			
			<div>
				<input type="submit" value="Valider"/>
				<input type="reset" value="Annuler"/>
			</div>
			
		</form>	
	</div>


</body>
</html>