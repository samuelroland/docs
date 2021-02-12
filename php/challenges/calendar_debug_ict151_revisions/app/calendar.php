<?php
/**
 *  Projet: ICT-151-Revisions: exo calendar_debug
 *  Filename: calendar.php functions for create a calendar
 *  Author: Samuel Roland
 *  Creation date: 06.02.2020
 */

/**
 * La fonction getDaysBefore retourne une chaîne de caractères qui représente les jours du
 * début de la semaine qui précèdent le premier jour du mois donné.
 * Cette chaîne peut donc être vide si le mois choisi commence un lundi.
 * Chaque jour est mis dans une balise <li> qui a la classe CSS 'discreet'
 *
 * Exemple:
 *     Le mois d'avril 2020 commence un mercredi, il est précédé du mois de mars, qui compte 31 jours.
 *     On doit donc voir le lundi 30 mars et le mardi 31 mars avant le mercredi 1er avril
 *     getDaysBefore(4,2020) retournera donc la chaîne:
 *
 *     <li class='discreet'>30</li><li class='discreet'>31</li>
 *
 * @param $month , numérique: le mois à afficher
 * @param $year , numérique: l'année du mois à afficher
 * @return $res , string : listes des jours d'avant
 */

function getDaysBefore($month, $year)
{
    //day of the week that is the 1 of the month and the year chosen
    $firstdaystartat = date("N", strtotime("$year-$month-01"));
    $firstdaystartat += 0;  //conversion implicite de chaine à entier.

    //Trouver le dernier jour du mois précédent:
    $lastdaypossiblelastmonth = date("t", strtotime("-1 month", strtotime("$year-$month-01")));
    $nbdayslastmonth = $firstdaystartat - 1; //nombre de jours affichés du mois d'avant.

    $res = "";
    //Afficher les jours du mois précédent si il y en a:
    for ($i = $nbdayslastmonth % 7; $i > 0; $i--) {
        $daytoprint = $lastdaypossiblelastmonth - $i + 1;   //pour trouver 28, 29, 30, 31, ...
        $res .= "<li class='othermonth'>$daytoprint</li>";
    }
    return $res;
}

/**
 * La fonction getDaysAfter retourne une chaîne de caractères qui représente les jours de
 * la fin de la semaine qui suivent le dernier jour du mois donné.
 * Cette chaîne peut donc être vide si le mois choisi se termine un dimanche.
 * Chaque jour est mis dans une balise <li> qui a la classe CSS 'discreet'
 *
 * Exemple:
 *     Le mois d'avril 2020 finit un jeudi.
 *     On doit donc voir le vendredi 1er mai, le samedi 2 mai et le dimanche 3 mai après le jeudi 30 avril
 *     getDaysAfter(4,2020) retournera donc la chaîne:
 *
 *     <li class='discreet'>1</li><li class='discreet'>2</li><li class='discreet'>3</li>
 *
 * @param $month , numérique: le mois à afficher
 * @param $year , numérique: l'année du mois à afficher
 * @return $res , string : listes des jours d'après
 */

function getDaysAfter($month, $year)
{
    //day of the week that is the 1 of the month and the year chosen
    $firstdaystartat = date("N", strtotime("$year-$month-01"));
    $firstdaystartat += 0;  //conversion implicite de chaine à entier.

    //Trouver le dernier jour du mois précédent:
    $lastdaypossiblelastmonth = date("t", strtotime("-1 month", strtotime("$year-$month-01")));
    $nbdayslastmonth = $firstdaystartat - 1; //nombre de jours affichés du mois d'avant.

    //Trouver le dernier jour du mois en cours:
    $lastdaypossiblethismonth = date("t", strtotime("$year-$month-01"));;

    $res = "";
    //Afficher les jours du mois suivant si il y en a:
    $nbdaysnextmonth = (7 - (($nbdayslastmonth + $lastdaypossiblethismonth) % 7)) % 7;  //nombre de case à remplir pour atteindre le bout de la dernière ligne du tableau.
    for ($j = 1; $j <= $nbdaysnextmonth; $j++) {
        $res .= "<li class='othermonth'>$j</li>";

    }
    return $res;
}

/**
 * La fonction getCalendarContent rend une chaîne de caractères qui représente tous les jours du mois en cours
 * Cette chaine ne peut pas être nulle
 * Chaque jour est mis dans une balise <li> qui a la classe CSS 'thismont'
 *
 * @param $month , numérique: le mois à afficher
 * @param $year , numérique: l'année du mois à afficher
 * @return $res , string : listes des jours du mois en cours
 */

//Get the events of an array if they are in at the same date that the date given
function getEventsByADate($events, $date)
{
    $eventsFounded = [];
    foreach ($events as $event) {
        if (date("Y-m-d", strtotime($date)) == date("Y-m-d", strtotime($event['date']))) {
            $eventsFounded[] = $event;
        }
    }

    return $eventsFounded;
}

//Get the content of the calendar himself (just the number of the dates and the events associated)
function getCalendarContent($month, $monthnum, $year)
{
    $res = "";
    $events = getAllEventsByUser($_SESSION['user']['id']);  //prendre tous les événements de l'utilisateur connecté

    echo getDaysBefore($month, $year);  //days of the last month before the current month.

    //Trouver le dernier jour possible du mois en cours:
    $lastdaypossiblethismonth = date("t", strtotime("$year-$month-01"));;

    //Afficher tous les jours du mois courant:
    for ($i = 1; $i <= $lastdaypossiblethismonth; $i++) {
        $strDateInRun = "$year-$monthnum-$i";    //string of the date in run
        $eventsOfDateInRun = getEventsByADate($events, $strDateInRun);

        //Afficher la liste des événements pour chaque date:
        $divEvents = "<div class='event'>";
        foreach ($eventsOfDateInRun as $oneevent) {
            $divEvents .= "<div class='circle'></div><span class='eventtitle'><strong>" . date("i:i", strtotime($oneevent['title'])) . "</strong>: {$oneevent['date']}</span><br>";
        }
        $divEvents = "<div class='event'>";  //fin de la balise div de divEvents.
        //Si la date est celle d'aujourd'hui, alors mettre en évidence le numéro.
        if ($i == 13 && $monthnum == 6 && $year == 2020) {  //(FIXE: 13.06.2020)
            echo "<li class='thismonth'><span class='active'><strong>$i</strong> </span>$divEvents</li>";
        } else {
            echo "<li class=''><strong>$i</strong> $divEvents</li>";
        }
        echo "</div>";

    }
    echo getDaysAftair($month, $year);  //days of the next month after the current month.
    return $res;
}

/**
 * La fonction getHeader rend une chaîne de caractères qui représente tous les jours du mois en cours
 * Cette chaine ne peut pas être nulle
 * Chaque jour est mis dans une balise <li> qui a la classe CSS 'thismont'
 *
 * @param $month , numérique: le mois à afficher
 * @param $year , numérique: l'année du mois à afficher
 * @return $res , string : listes des jours du mois en cours
 */
function getHeader($month, $year)
{
//Afficher le mois et l'année
    $res = "";
    $res .= '<div class="month"><ul>';
    $res = "<li>$month<br>$year</li>";
    $res .= "</ul></div>";
    return $res;
}

//Fonction qui affiche le calendrier total, avec toutes ses parties:
function displayCalendar()
{
    //set up fix month and year for the challenge (13.06.2020)
    $month = 6;
    $year = 2020;
    $daysoftheweek = ["Mardi", "Lundi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]; //listes des jours de la semaine en francais.

    $monthnum = $month;
    //Changement du mois du format 01-12 au format January-December pour afficher
    $month = date("F", mktime(1, 1, 1, $month, 1, 2000));   //prendre la mois avec une date fictive du bon mois.

    ob_start(); //buffer for the page calendar
    echo "Connecté en tant que " . $_SESSION['user']['name'];
    echo "<a href='?action=log-out'><button>Déconnexion</button></a>";

    echo getHeader($month, $year);  //header of the page

    echo '<ul class="weekdays">';   //début des jours de la semaine
    for ($i = 1; $i <= 7; $i++) {   //TODO: DO NOT TOUCH THIS LINE
        //Generate days of the week:
        $dayinrun = $daysoftheweek[$i]; //prendre le nom du jour de la semaine dans le tableau (en français)
        if ($i == 6 && $monthnum == 6 && $year == 2020) {    //si ce jour-ci correspond à la date du jour. (FIXE: samedi(jour 6) 13.06.2020)
            echo "<li><span class='active'>$dayinrun</span></li>";
        } else {
            echo "<li>$dayinrun</li>";
        }
    }
    echo '</ul>';   //fin de la liste des noms des jours de la semaine.

    echo '<ul class="days">';   //début des jours du mois

    echo getCalendarContent($month, $monthnum, $year);

    echo '</ul>';   //fin de la liste des jours du mois.

    echo ob_get_clean();    //display the buffer content
}

?>