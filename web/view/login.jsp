<%-- 
    Document   : index
    Created on : May 14, 2025, 6:57:40 PM
    Author     : mirai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="Css/newcss.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
         <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
        function enableSubmitBtn() {
            document.getElementById("submitBtn").disabled = false;
        }
    </script>
 
    </head>
    <body>

  <div class="container">
      <div class="left-side">
          <img src=https://media.discordapp.net/attachments/1274345600380440649/1372222109509750844/image-removebg-preview.png?ex=6825fced&is=6824ab6d&hm=11ee47208399f526770b2802a2a11368bf8013b7bed1b3746ba177ddb59d20a4&=&format=webp&quality=lossless id=image3 />
          <div class="welcome-text">Dive in. Explore.<br> Learn Actively</div>
        <div class="subtext">If you don't have an account <br>you can  <a href="#">Register here!</a></div>
          <img src=https://media.discordapp.net/attachments/1274345600380440649/1372224628256145459/upscalemedia-transformed.png?ex=6825ff46&is=6824adc6&hm=9a767bb2f42393d80bb80e7fc4b3498b74454376e3d52e24f89f59a5cc64b7f9&=&format=webp&quality=lossless&width=648&height=648 id="image2"/>
    
    </div>

      <div class="right-side">
        <form>
            <img src=https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFUMhLPEbvTVzkqRcw5ZYkMEWojxhrEVBS_Q&s id=image4 />
             <h1>Log-in</h1>
          
          
          <fieldset>
                 <label>Enter username:<br> <input type="text" name="username" required placeholder="e.g: user1"/></label><br>
                <label>Enter password:<br> <input type="password" name="password" required placeholder="e.g: password1"/></label><br>
                 <br>
                     <div class="captcha-container">
                      <div class="g-recaptcha" data-sitekey="6LcF3fsqAAAAAD8SdWJzzJlpIOitZI8OV9wD5r8_" data-callback="enableSubmitBtn"></div>
                     </div>
                       <br>
                        <input type="submit" id="submitBtn" value="Login" disabled>
               </fieldset>
        </form>
   </div>
</div>

</body>
</html>
