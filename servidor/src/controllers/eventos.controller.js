const {pool} = require('../database/postgeSQL');

const getEventos =  async (req,res) => {
    var newJson = {"Cantidad":2,"Datos":[{}]}
    const response =  await pool.query('SELECT * from eventos');
    newJson["Datos"]=response.rows
    res.json(newJson)
}

const postEventos =  async (req,res) => {
    var nombre = req["body"]["nombre"];
    var fechainicio = req["body"]["fechainicio"];
    var fechafin = req["body"]["fechafin"];
    var estododia = req["body"]["estododia"];
    var descripcion = req["body"]["descripcion"];
    const response =  await pool.query("SELECT AgregarEvento("+"'"+nombre+"'"+","+"'"+fechainicio+"'"+","+"'"+fechafin+"'"+","+"'"+descripcion+"'"+","+"'"+estododia+"'"+")");
    
    res.json(response.rows[0]["agregarevento"]["respuesta"]);
   
}

const postEliminarEventos =  async (req,res) => {
    var id = req["body"]["id"];
   
    const response =  await pool.query("SELECT eliminarevento("+"'"+id+"'"+")");
    console.debug(response.rows[0]["eliminarevento"]["respuesta"]);
    res.json(response.rows[0]["eliminarevento"]["respuesta"]);
}

const postModificarEventos =  async (req,res) => {
    var id = req["body"]["id"];
    var nombre = req["body"]["nombre"];
    var fechainicio = req["body"]["fechainicio"];
    var fechafin = req["body"]["fechafin"];
    var estododia = req["body"]["estododia"];
    var descripcion = req["body"]["descripcion"];
    const response =  await pool.query("SELECT ModificarEvento("+"'"+id+"'"+","+"'"+nombre+"'"+","+"'"+fechainicio+"'"+","+"'"+fechafin+"'"+","+"'"+descripcion+"'"+","+"'"+estododia+"'"+")");
    res.json(response.rows[0]["modificarevento"]["respuesta"]);
}



module.exports = {getEventos,postEventos,postEliminarEventos,postModificarEventos};