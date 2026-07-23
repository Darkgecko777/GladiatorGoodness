class_name GladiatorNameData
extends RefCounted

## Single-name pools for gladiator generation.
## Cognomen / epithet is a separate optional slot and is not handled here.

const LATIN: Array[String] = [
	"Lucius", "Marcus", "Gaius", "Quintus", "Titus", "Sextus", "Aulus", "Decimus", "Publius", "Tiberius",
	"Cassius", "Severus", "Varro", "Drusus", "Nero", "Galba", "Otho", "Vitellius", "Flavius", "Domitius",
	"Valerius", "Cornelius", "Aemilius", "Fabius", "Horatius", "Livius", "Marcellus", "Maximus", "Regulus", "Scaevola",
	"Brutus", "Cassian", "Lucan", "Marian", "Octavian", "Priscus", "Verus", "Flamma", "Triumphus", "Spiculus",
	"Columbas", "Hermes", "Scorpius", "Leo", "Taurus", "Aquila", "Lupus", "Ursus", "Vulcan", "Fortunatus", "Felix"
]

const GREEK: Array[String] = [
	"Alexios", "Demetrios", "Nikias", "Leonidas", "Lysander", "Damon", "Theron", "Pyrrhus", "Kassandros", "Aristides",
	"Helios", "Asterion", "Phaon", "Karyos", "Melas", "Leander", "Orthros", "Xenon", "Thales", "Kriton",
	"Ajax", "Achilles", "Hector", "Patroclus", "Diomedes", "Odysseus", "Perseus", "Theseus", "Orion", "Icarus",
	"Castor", "Pollux", "Nestor", "Telemon", "Glaucus", "Sarpedon", "Memnon", "Bellerophon", "Cadmus", "Orpheus"
]

const THRACIAN: Array[String] = [
	"Spartacus", "Crixus", "Gannicus", "Oenomaus", "Castus", "Dagan", "Bato", "Decebal", "Rhoemetalces", "Cotys",
	"Thrax", "Dacius", "Sarmata", "Scythas", "Getas", "Bessi", "Maedi", "Dentatus", "Vindex", "Arminius",
	"Alaric", "Theodoric", "Gundahar", "Maroboduus", "Vannius", "Catualda", "Ballomar", "Ariovistus", "Segestes", "Flavus"
]

const GALLIC: Array[String] = [
	"Vercingetorix", "Ambiorix", "Dumnorix", "Orgetorix", "Cassivellaunus", "Caratacus",
	"Brennus", "Diviciacus", "Lucterius", "Viridovix", "Correus", "Critognatus", "Eporedorix", "Cotuatus",
	"Segovax", "Cingetorix", "Tasgetius", "Indutiomarus", "Acco", "Convictolitavis", "Litaviccus", "Sedullus"
]

const MYTHIC: Array[String] = [
	"Colossus", "Titan", "Atlas", "Prometheus", "Hyperion", "Kronos", "Argus", "Cerberus", "Hydra",
	"Phoenix", "Griffin", "Chimera", "Manticore", "Sphinx", "Gorgon", "Harpy", "Siren",
	"Gladius", "Scutum", "Pilum", "Hasta", "Sica", "Trident", "Net",
	"Invictus", "Immortalis", "Victor", "Fortis", "Audax", "Ferox", "Crudelis", "Sanguis"
]

const SHORT: Array[String] = [
	"Rex", "Duo", "Trio", "Pax", "Nox", "Lux", "Sol", "Umbra",
	"Iron", "Flint", "Ash", "Storm", "Thorn", "Fang",
	"Pike", "Brand", "Hook", "Chain", "Spike", "Crow"
]


## Default pool for ordinary human gladiators: Latin + Greek + Thracian.
static func get_standard_pool() -> Array[String]:
	var pool: Array[String] = []
	pool.append_array(LATIN)
	pool.append_array(GREEK)
	pool.append_array(THRACIAN)
	return pool


static func get_all_names() -> Array[String]:
	var pool: Array[String] = []
	pool.append_array(LATIN)
	pool.append_array(GREEK)
	pool.append_array(THRACIAN)
	pool.append_array(GALLIC)
	pool.append_array(MYTHIC)
	pool.append_array(SHORT)
	return pool


static func pick_random_name(use_full_pool: bool = false) -> String:
	var pool := get_all_names() if use_full_pool else get_standard_pool()
	if pool.is_empty():
		return "Nameless"
	return pool[randi() % pool.size()]
