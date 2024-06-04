namespace Dominio.Entidad.CrediMovilLima.Entidad
{
    public class Cliente
    {
        public int IdCliente { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string DNI { get; set; }
        public string Correo { get; set; }
        public string Celular { get; set; }

        // Constructor vacío
        public Cliente()
        {
        }

        // Constructor con todos los parámetros
        public Cliente(int idCliente, string nombres, string apellidos, string dni, string correo, string celular)
        {
            IdCliente = idCliente;
            Nombres = nombres;
            Apellidos = apellidos;
            DNI = dni;
            Correo = correo;
            Celular = celular;
        }

        // Métodos adicionales como ToString, etc., pueden ser agregados aquí si es necesario
    }

}
