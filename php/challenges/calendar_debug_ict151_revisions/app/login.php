<?php

//login function that display the login page or that try to login the user with the data sent with POST.
function login($username, $password)
{
    ob_start(); //start the buffer for the view
    ?>

    <div action="?action=login" method="get">
    <h1>Connexion</h1>
        <div>
            <label for="username">username</label>
            <input type="text" required>
        </div>
        <div>
            <label for="password">password</label>
            <input type="password" name="motdepasse" required>
        </div>
        <div>
            <div>
                <button type="submit">Se connecter</button>
            </div>
        </div>
    </form>

    <?php
    $content = ob_get_clean()  //get the buffer with the view

    if (is_null($username) == false) {  //if informations for login have been sent
        $user = getOneUser($username);  //get the user with the username sent
        if (password_verify($password, $user['password'])) {    //verify the password sent with the hashed one
            unset($user['password']);
            $_SESSION['user'] = $user;
            displayCalendar();  //is logged, go to the calendar.
        } else {
            echo "mauvais identifiants..."; //if error, display msg
            echo $content;  //return back to the login page...
        }
    } else {
        echo $content; //go to to the login page because no data have been sent.
    }
}


?>