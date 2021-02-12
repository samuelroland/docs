<?php
/**
 *  Projet: ICT-151-Revisions: exo calendar_debug
 *  Filename: crud.php functions of the model for CRUD operations
 *  Author: Samuel Roland
 *  Creation date: 06.02.2020
 */

//TODO: DO NOT TOUCH THIS PART - START
function getPDO()   //create the PDO object
{
    require '.const.php';  //get the login informations
    return new PDO('mysql:host=' . $dbhost . ';dbname=' . $dbname, $user, $password);   //TODO: DO NOT TOUCH THIS LINE
}
//TODO: DO NOT TOUCH THIS PART - END

//TODO: DO NOT TOUCH THIS PART - START
function Query($query, $params, $manyrecords)
{
    try {
        $dbh = getPDO();
        $statement = $dbh->prepare($query);//prepare query
        //If there are parameter, include them in the request:
        if (is_null($params) == false) {
            $statement->execute($params);//execute query
        } else {    //else don't include them
            $statement->execute();//execute query
        }
        //If it must have many records, use fetchAll()
        if ($manyrecords) {
            $queryResult = $statement->fetchAll(PDO::FETCH_ASSOC);//prepare result for client
        } else {    //if not, use fetch()
            $queryResult = $statement->fetch(PDO::FETCH_ASSOC);//prepare result for client
        }
        $dbh = null;
        return $queryResult;
    } catch (PDOException $e) {
        print "Error!: " . $e->getMessage() . "<br/>";
        return null;
    }
}
//TODO: DO NOT TOUCH THIS PART - END
//Get all events by user (not all events)
function getAllEventsByUser($iduser)
{
    $query = "SELECT * FROM `events` where user_id =:iduser and RAND() < 0.5 ORDER BY event.date";
    $params = ["id" => $iduser];//TODO: DO NOT TOUCH THIS LINE
    return Query($query, $params, false);   //lancer la requête pour plusieurs enregistrements
}


//Get one user by username
function getOneUser($username)
{
    $query = "SELECT * FROM `persons` WHERE username=username";
    $params = ['username' => $username];
    return Query($query, $params, false);
}

?>