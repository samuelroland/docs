# Mémento PHP orienté pratique ICT-133
## Les bases du php, les spécialités et points importants.

### Règles et notions générales:
- Pas besoin de déclarer les variables et leur type.
- Toutes les variables commencent par `$`. Ca indique que ce qui suit c'est une variable. Ex: `$age = 18;`
- Tout le code php se trouve dans une balise PHP:

    <?php
    echo "salut";
    ?>

On peut remplacer: `<?php echo $name; ?>` par `<?= $name ?>` quand il n'y a qu'une valeur à afficher dans un bout de HTML (plus besoin de `echo` du coup ni de `;`).


- Toutes les lignes de code en dehors de celle propre au instructions (après `{` ou `case 4:`, voir les instructions plus bas), ont un `;` à la fin. En cas d'oubli ou d'erreur, la page ne pourra pas être générée.

        $x = 12;
        $y = "Hello";

Attention comme il n'y a pas de déclaration du types de variables, de ne pas avoir deux variables différentes avec le même nom (pour deux valeurs différentes):

    $x = 12;
    $x = "Hello";

Les variables n'ont pas de type fixes et définis au départ (string, boolean, int, float, double, ...) comme dans d'autres langages. Le type dépend de la valeur contenue. Ainsi si la valeur change de type (on passe de 8 à "bonjour" comme valeur par ex.), les variables **changent de type**. Si on a par exemple une valeur numérique stockée en string (ex: 
"8") et qu'on a besoin de changer, on peut faire un changement implicite en faisant une action propre au type que l'on veut obtenir.

Exemple avec "8"

    $i = "8";  	//$i est de type string.
    
    $i = $i + 0;	//on fait un calcul (ici on ne veut pas changer la valeur) et le type change.
     
    switch($i){ ...  //on peut donc l'utiliser comme un int

puis on fait `$i .= "";` on le concatène avec rien (.= meme principe que +=) et il devient de type string.

#### Les constantes
Il est aussi possible de définir des constantes avec `define("CONSTANTE_NAME", <value>);`. 

Exemple:

    define("NOMDUCOURS", "ICT-133");

Ensuite on pourra appeler la constante par son nom et donc sans `$`. `echo NOMDUCOURS;`


### Résumé des syntaxes:

#### Les instructions et boucles
If (condition "si")

    if ($i > 5){
        echo $i;
    }

If ... else... (condition "si...sinon...")

    if ($i > 5){
        echo $i;
    }else {
        echo "erreur";
    }

For (boucle)

    for ($i=0; $i<4; $i++){
        echo "Numéro $i";
    }

While (boucle "tant que")

    while ($i == null){
        $j++;
        if ($j > 8){
            $i = $j;
        }
    }

Switch (condition "commutateur")

    switch ($age){
        case 5:
            echo "Vous êtes un enfant.";
            break;
        case 15:
            echo "Vous êtes un ado.";
            break;
        case 18:
            echo "Vous êtes un adulte.";
            break;
        case 90:
            echo "Vous êtes retraité.";
            break;
    }

Foreach (boucle "pour chaque")
--> voir plus bas.

#### Déclaration de fonction
Sans paramètre:

    function homepage(){
        echo "Bienvenu sur la page d'accueil";
        ...
    }
    
Avec paramètres:

    function details($type, $model){
        if (type == 4){
            echo "Le snow du modèle $model est mort.";
        }
        ...
    }

Avec une valeur retournée:

    function getAllFilmmakers()
    {
        $filmmakers = json_decode("model/dataStorage/filmmakers.json", true);
        return $filmmakers;
    }


### Tableaux:

Dans un langage qui demande de définir un type aux données, un tableau, est **un ensemble de valeur de même type**. Sauf que en php ce n'est pas le cas et donc aucun problème technique pour déclarer ça: `$test = [0, 0.5, "salut", 'x', true];`. Donc pleins de types différents dans le même tableau!

*Mais alors c'est un ensemble de quoi ?*

C'est un ensemble de valeurs et/ou de tableaux... désolé pour ce flou, mais je ne vois pas plus précis.

Traditionnelement, un tableau se crée avec la fonction `array();`

    $contacts = array("John", "David", "Romain", "Jules");

La nouvelle syntaxe simplifiée permet de remplacer array( ... ) par [ ... ].

Il existe 3 types de tableaux que nous allons voir maintenant en détail, avec des données concrètes.

#### Les tableaux indexés (comme en C)
Les valeurs sont numérotées avec un index partant de 0 par défaut. Si on définit l'index nous-même (en indexant avec l'id par exemple), on aura les index choisis.

    $cars = array("Volvo", "BMW", "Toyota");

- Volvo est à l'index 0
- BMW est à l'index 1
- ...

Pour utiliser tous les éléments il suffit de faire une boucle.
On écrit ou lit la valeur en trouvant l'index grâce à la variable d'itération de notre boucle (ici `$i`).

    for ($i = 0; $i < 3; $i++){
        echo $cars[$i];
    }

Exemple: 

    $cars[1] = "Volvo";
    $cars[6] = "BMW";
    $cars[4] = "Toyota";

#### Les tableaux associatifs
Chaque valeur est lié (=>) à une clé. La clé désigne la signification de la valeur.

    $contactInfo = array(
        'name' => 'John Doe',
        'address' => 'Rue de Lausanne 25',
        'NPA' => 1400,
        'City' => 'Yverdon'
    );

- John Doe est lié à name
- 1400 est relié à NPA.

On ne peut pas faire de boucles FOR puisque il n'y a plus d'index, alors on fait une boucle foreach (voir théorie du foreach plus bas):

    foreach ($contactInfo as $info){
        echo $info." ";	    //ici $info prend chaque valeur du tableau.
    }

Si on oublie de mettre un clé, un index est automatiquement mis.

Ou alors pour prendre une case dont on connait la clé, on met la clé entre '[' et ']'

    $contactInfo["name"] = "John Assange";


#### Les tableaux multidimensionnels:

    $people = array(
        array('Perceval','Arthur','Lancelot','Leodagan'),
        array('Marge','Homer','Bart','Maggie'),
        array('Joe','Jack','William','Averell')
    );

ou

    $people = [
        ['Perceval','Arthur','Lancelot','Leodagan'],
        ['Marge','Homer','Bart','Maggie'],
        ['Joe','Jack','William','Averell']
    ];

`$people` est ici un tableau indexés de tableaux indexés.

En créant des tableaux dans une case, on obtient un tableau 1D dans un case donc deux dimensions finalement. Il est possible d'avoir autant de dimensions que souhaité.

Fonctions intéressantes pour tableau:
`extract();` extrait les clés d'un tableau et les copie en variables
`implode();` Rassemble les éléments d'un tableau en une chaîne
...

Comme dit précèdemment, on peut indexer "manuellement" au lieu d'automatiquement si ça a un intêret. 

Voici un exemple dans lequel cela pourrait être intéressant avec les données suivantes (une liste des concerts avec les concerts indexés automatiquement):

    $listofconcerts = [
        0 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        1 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        2 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ],
    ];

Ce qui n'est pas pratique, c'est que pour prendre le concert avec l'id 7, on devra parcourir le tableau à l'aide d'une boucle pour rechercher le concert recherché.

Maintenant si on décide d'indexer manuellement:

    foreach ($listofconcerts as $oneconcert){
        $newlist[$oneconcert['id']] = $oneconcert;
    }
    
... il suffira de faire `$newlist[7]` pour atteindre le concert avec l'id 7 !

Vous aurez donc l'équivalent de ce résultat:

    $newlist = [
        15 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        7 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        12 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ]
    ];

**ATTENTION**: on remarque ici la présence d'un **nouveau tableau `$newlist`**. Ceci est très important parce que si vous utilisez `$listofconcerts`, vous aurez un mélange de doublons et d'écrasements, puisque les données aux index 0, 1 et 2 n'ont pas été supprimées.

Pour être concret, vous aurez un tableau comme ceci si vous faite cette erreur:

    $listofconcerts = [
        0 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        1 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        2 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ],
        15 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        7 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        12 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ]
    ];

Donc des simples doublons assez perturbant et problématique. Pas d'écrasement ici, mais le ca aurait été le cas si une id valait 0, 1 ou 2.

##### Conclusion pour les tableaux:
Quand on regarde (souvent) les valeurs contenus dans un tableau, on ne peut pas faire un simple `echo $tableau;`, parce que le résultat affiché sera `Array` ce qui ne nous donne pas beaucoup d'informations sur son contenu...

Il existe donc **2 fonctions très utiles** qui permettent d'**afficher le contenu d'un tableau** avec un design, et aussi évidemment une simple variable:
- `var_dump($tableau);`
- `print_r($tableau);`

Le **design est un peu différent** et surtout l'une des deux se prête mieux à l'**affichage en navigateur** et l'autre à l'**affichage en mode console** dans un shell (pour faire des tests unitaires sur des fonctions par exemple...). 

A vous de tester et de regarder lesquels vous voulez utiliser. Elles restent **très très pratique pour avoir une vue compréhensible** du contenu d'un tableau, et doivent être, selon moi, utilisé sans modération.

#### Manipulation de chaines de caractères:
Les différentes manipulations résumées avec l'acronyme **MERCI**:

- **Mesurer**: `count($tableau`) retourne nombres d'éléments du tableaux, ou `strlen($myrandomstring)` retourne la longueur de la chaine.
- **Extraire**: `substr(thestring, startpos, length)` retourne la chaine extraite
- **Rechercher**: `strpos( string $haystack , string $needle , int $offset = 0 ) : int|false` cherche une aiguille dans une botte de foin donc une sous chaine dans une chaine.
- **Concaténer**: `<li>Produit numéro " . $i . "</li>` ou `<li>Connecté en " . $user['firstname'] . "</li>` On met un "." au lieu du "+" en C# ou en javascript. 
- **Interpoler**: `<li>Produit numéro $i</li>`. Attention double guillemets obligatoires et ça ne fonctionne pas avec les tableaux ! Dans ce cas on doit utiliser la concaténation, ou alors on entoure le tableau de `{` `}` ce qui donne: `<li>Connecté en {$user['firstname']}</li>`

Beaucoup d'autres fonctions existent sur [php.net](https://www.php.net) et particulièrement ici [à propos des chaines de caractères](https://www.php.net/ref.strings):
- `str_replace("_", " ", $filename`) remplacer une sous-chaine par une autre. Ex: la chaine "_" par la chaine " " dans `$filename`.
- `str_repeat ( string $input , int $multiplier ) : string` répéter une chaine
- `substr_count()` --> Compter le nombre d'occurences d'une sous-chaine.

#### Raccourci d'opérations:
Pour un calcul:

`$i = $i + 2;` => `$i += 2;`

Pour une concaténation
`$string = $string . " cool";` => `$string .= " cool";`

#### Affichage de dates:
date ( string $format [, int $timestamp = time() ] ) : string

$format = format voulu ("Y-m-d" par exemple).

$timestamp = par défaut le temps de maintenant ou une date donnée.

Toutes les syntaxes sont sur [ce lien pour la fonction date()](https://www.php.net/manual/en/function.date.php)

Pour se mettre sur le fuseau horaire de la suisse, on ajoute:
`date_default_timezone_set("Europe/Zurich");`

Exemples de syntaxes:

    echo "<li>".date('l d F Y')."</li>";
    echo "<li>".date('M jS Y')."</li>";
    echo "<li>".date('d/m/Y H:i a')."</li>"
    echo "<li>".date('d M Y, H:i:s')."</li>";
    echo "<li>".date('r')."</li>";

Résultats:

    Thursday 28 November 2019
    Nov 28th 2019
    28/11/2019 11:41 am
    28 Nov 2019, 11:41:02
    Thu, 28 Nov 2019 11:41:02 +0100


#### Principe du gabarit:
La gabarit c'est un modèle (concrètement une page html qui contient en-tête et pied de page) et qui contient des zones qui sont générées par d'autres pages. C'est un template.

#### MVC
MVC = Modèle, Vue et Contrôleur. Cela consiste à séparer les données, de ce qui est affiché et de la logique effectuée, en séparant les pages php qui ont un rôle bien précis. Détails dans ![MVC explication.md](MVC explication.md)

#### Lier les pages:
Puisque chaque pages à un but particulier (en MVC) mais qu'une seule page ne suffit pas, il faut pouvoir les lier.

3 manières de lier les pages entre elles:
- `require('nomfichier');`
- `require_once('nomfichier');`
- `include();`

Dans les 3 cas, le résultat est exactement le même que si on copiait à la place le contenu du fichier appelé.

Différences: si le fichier appelé n'existe pas:
- `require()`: crash
- `require_once()`: crash
- `include`: n'inclut rien.


**ATTENTION**: Comme les pages php sont comme copiés collés dans le fichier qui faire require,  le **chemin relatif** des fichiers sont relatifs **par rapport à la première page** (page demandée dans la requête donc `index.php` pour nous).

#### Accessibilité des variables
Les variables créés sont atteignables si on cherche à les atteindre depuis la même fonction. Attention la même fonction peut se trouver sur plusieurs fichiers php lié avec `require*` comme la fonction du controleur qui fait `require*` d'une vue.
Les variables ne sont pas atteignables directement quand elles se trouvent dans des fonctions différentes ou alors qu'on cherche à atteindre une variable à l'exterieur d'une fonction alors qu'on est dedans la fonction (et inversemment). Il faut donc les envoyer à travers les paramètres d'une fonction pour avoir leur valeur. Toutes les variables en dehors des fonctions sont accessibles directement par toutes les pages en étant à l'extérieur des fonctions.

Attention cependant à l'ordre dans lequel sont liés les pages et à l'initialisation des variables. Même chose pour les fonctions.
Attention cependant à l'ordre dans lequel sont liés les pages et à l'initialisation des variables. Même chose pour les fonctions.

#### Buffer (mémoire tampon)
Utilité:
Permettre de générer un certain contenu sans l'afficher directement mais en faisant comme si on l'affichait. Donc on fait des echo et des bouts de html seuls mais ca n'est pas affiché. Ca va dans le buffer.

Fonctions pour le buffer:

`ob_start();`	output buffer start = met un charriot à la sortie de la salle. (tout ce qui va suivre/sortir ca va dans le buffer)
    
`$content =  ob_get_clean();`	on récupère (get) le contenu du charriot et on le met dans `$content` et on vide le charriot (clean)


Exemple:

    <?php
    ob_start();	//départ du buffer
    ?>
        <a href='?action=movies'><img src="images/movies.jpg" alt="movies" height="250px"></a>
        <a href='?action=concerts'><img src="images/concerts.jpg" alt="movies" height="250px"></a>
    <?php
    $content = ob_get_clean();recevoir le buffer
    ?>

`isset($_GET['action']);` retourne si la **variable** est existe (false si n'existe pas). Attention vide ne veut pas dire non-existant. Si on fait `$prenom = "";` alors `$prenom` existe mais est vide. Pour savoir si une variable est vide ou non on utilisera `""` ou alors `empty();`

`unset();`	détruit une variable. Elle n'existe plus.


#### Boucle Foreach:
Littéralement **"pour chaque"**, la boucle foreach permet de **parcourir les éléments d'un tableau**. Elle ressemble à la boucle for dans son fonctionnement mais on travaille avec de manière différente.

La boucle foreach a besoin de 2 données pour pouvoir fonctionnner. Elle a besoin d'un **tableau** (tous les types et les structures sont compatibles) pour pouvoir faire un tour de boucle pour chaque élément du tableau. Et aussi d'une **variable** dans laquel l'élément en cours du tableau puisse être "copié". L'élément en cours peut-être un autre tableau ou une "variable"/directement une valeur.

L'avantage sur la boucle for c'est de pouvoir **tout prendre d'un coup**, mais aussi surtout d'atteindre des éléments **dont on ne connait pas la clé ou l'index**.

##### Exemple 1 (tableau de tableaux = multidimensionnel):

Prenons les données suivantes, `$listofconcerts` étant un tableau indexés de tableaux associatifs.

    $listofconcerts = [
        0 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        1 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        2 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ],
    ];

Maintenant affichons la liste des concerts avec leur nom et leur date:

    foreach ($listofconcerts as $concert) {
		echo "<p>{$concert['name']} le {$concert['date']}.</p>";
	}

Ce qui donne:

	The big night le 2020-02-15.
	
	Great deal le 2020-03-15.
	
	The perfection le 2020-05-09.

Imaginons maintenant qu'on veut modifier le tableau `$listofconcerts` et qu'on veut ne pas afficher les concerts après le `2020-03-30`. On a besoin de modifier le tableau et de supprimer les concerts après cette date. Sauf que de faire un unset() sur `$concert` de la manière suivante...

	foreach ($listofconcerts as $concert) {
		if ($concert['date'] > "2020-03-30") {
			unset($concert);
		}
	}

... ça ne fonctionne pas !

C'est différent qu'en C# ! Car la variable `$concert` n'est qu'une copie et pas un "lien" sur l'élément réel. C'est parfait pour accéder en lecture mais pas prévu pour faire des modifications ou des suppressions.

Pour résoudre ce problème d'accès comme en lecture seule, il existe **une deuxième syntaxe du foreach**. On peut ainsi utiliser l'index de l'élément en cours (ici `$i`) et utiliser le tableau réel avec cet index:

	foreach ($listofconcerts as $i => $concert) {
		if ($concert['date'] > "2020-03-30") {
			unset($listofconcerts[$i]);
		}
	}

**L'index** n'est pas le numéro de l'élément (j'entends par là de compter un élément après l'autre: 0, 1, 2, 3, 4 ...) mais l'index du tableau $listofconcerts sur lequel est indexé l'élément en cours.

Reprenons un exemple précédent:

    $listofconcerts = [
        15 => [
            "id" => 15,
            "name" => "The big night",
            "date" => "2020-02-15",
            "artist_id" => 8
        ],
        7 => [
            "id" => 7,
            "name" => "Great deal",
            "date" => "2020-03-15",
            "artist_id" => 5
        ],
        12 => [
            "id" => 12,
            "name" => "The perfection",
            "date" => "2020-05-09",
            "artist_id" => 19
        ]
    ];
	
	foreach ($listofconcerts as $i => $concert){
            echo " Index = $i ";
    }
	
Ici l'index `$i` sera successivement 15 puis 7 puis 12. (et nom 0, 1, 2 ou 1, 2, 3). Il ne faut donc pas utiliser `$i` comme un numéro pour savoir combien de concert on a parcouru par exemple...

	 Index = 15  Index = 7  Index = 12 

Cette exemple est d'ailleurs *idéal* pour montrer qu'**une boucle for ici n'a plus de sens** puisque les index ne sont pas définis automatiquement.


##### Exemple 2 (tableau 1 dimension):

Prenons d'autres données: un tableau simple à une dimension. Ici on a un contenu d'un article (en lorum ipsum) avec plusieurs parties.

    $article = [
        "intro" => "Quid de Pythagora?",
        "corps" => "Lorem ipsum dolor sit amet.",
        "conclusion" => "Est enim effectrix",
        "fin" => "Quis enim redargueret?",
    ];

Ou alors le même contenu, mais structuré en un tableau indexé.

    $article = ["Quid de Pythagora? ", "Lorem ipsum dolor sit amet.", "Est enim effectrix.", "Quis enim redargueret?"];

Dans les deux cas, on aimerait afficher toutes les parties dans des paragraphes `<p></p>`

Au lieu d'afficher chaque partie l'une après l'autre, on utilise le foreach, mais **cette fois l'élément en cours sera une clé ou un index, et non un tableau.**

    foreach ($article as $piece) {
        echo "<p>$piece</p>";
    }

Résultat:

	Quid de Pythagora?

	Lorem ipsum dolor sit amet.
	
	Est enim effectrix
	
	Quis enim redargueret?

Pour revenir sur la deuxième syntaxe du foreach: 

	$theconcert = [
		"id" => 15,
		"name" => "The big night",
		"date" => "2020-02-15",
		"artist_id" => 8
	];
	
	foreach ($theconcert as $i => $data) {
		echo "<br>" . $i . " - " . $data;
	}

Etant avec un tableau associatif, `$i` est une clé et non un index ! Par contre, c'est la même logique que pour un tableau indexé. Il vaudra successivement: `id`, `name`, `date`, `artist_id`.

Résultat de l'affichage:

	id - 15
	name - The big night
	date - 2020-02-15
	artist_id - 8

Voilà. Après ces exemples pas à pas, vous devriez avoir toutes les informations pour travailler correctement avec le foreach.


### Les variables superglobales
Il existe des variables qui ont des fonctionnements particulier et qui sont accessibles partout dans le code.

"Les Superglobales sont des variables internes qui sont toujours disponibles, quel que soit le contexte" tiré de [la doc sur les superglobales](https://www.php.net/manual/fr/language.variables.superglobals.php)

 Les variables superglobales sont :

- `$GLOBALS`
- `$_SERVER`
- `$_GET`
- `$_POST`
- `$_FILES`
- `$_COOKIE`
- `$_SESSION`
- `$_REQUEST`
- `$_ENV`

Ce sont des variables qui existent constamment et sont accessibles depuis partout (toutes les pages).

Quelques exemples des plus couramment utilisées:
- `$_GET` contient toutes les données envoyées par méthode GET (également visible dans l'url)
- `$_POST` contient toutes les données envoyées par méthode POST (non visible dans l'url)
- `$_SERVER` donne des informations sur le serveur et les requêtes HTTP.
- `$_SESSION` contient des données relatives à la session en cours. (par défaut vide, mais remplit par le code php qui l'utilise).


### Le concept de la session
Sans ce concept, le serveur recoit des requêtes de plusieurs utilisateurs qui demandent chacun plusieurs pages, mais le serveur ne peut pas savoir si une requête est faite par la même personne que sur une requête précédente. Impossible donc de se connecter puisque à la prochaine requête pour une nouvelle page, le serveur ne pourra pas nous différencier de quelqu'un d'autre...

Donc il lui faut un moyen d'identifier les ordinateurs et ainsi les reconnaitre.
Pour cela, un cookie est utilisé. Ce cookie est renvoyé à chaque requête, et s'il n'existe pas il est donné par le serveur. L'envoi de ces cookies est complétement gérée seule. Enfin il faut quand même lancer le mécanisme avec un `session_start();` 

WIP

### Le concept du login
Le login (la connexion en francais) est présent sur beaucoup de site web puisque c'est un moyen simple d'authentifier un utilisateur. Sur la base de théorie de ce mémento, il est possible d'apprendre à gérer 


