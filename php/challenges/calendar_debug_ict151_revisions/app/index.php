<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Calendar debug
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<?php
/**
 *  Projet: ICT-151-Revisions: exo calendar_debug
 *  Filename: index.php start file of the calendar
 *  Author: Samuel Roland
 *  Creation date: 06.02.2020
 */

session_start();
session_destroy();  //FOR TESTS ONLY!!!
require "crud.php";
require "loginpage.php";
require "calendar.php";
include "style.css";    //get the css ...
//Get the action from the querystring:
if (isset($_GET['action'])) {
    $action = $_GET['action'];
} else {
    $action = null;
}

//TODO: DO NOT TOUCH THIS PART - START
//Depend on the action:
switch ($action) {
    case "login":
        if (isset($_SESSION['user']) == false) {    //if user is not logged
            $username = $_POST['username'];
            $password = $_POST['password'];
            login($username, $password);    //try to login
        } else {
            displayCalendar();  //else display the calendar because already logged
        }
        //break
    case "logout":
        unset($_SESSION['user']);   //unset the session
        login(null, null);  //back to login page
        break;
    default:
        if (isset($_SESSION['user'])) { //if user is not logged
            displayCalendar();
        } else {
            login(null, null); //back to login page
        }
        break;
}
//TODO: DO NOT TOUCH THIS PART - END
?>
</body>
</html>