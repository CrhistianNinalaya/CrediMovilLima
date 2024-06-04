using Dominio.Entidad.CrediMovilLima.Abstraccion;
using Dominio.Entidad.CrediMovilLima.Entidad;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;

namespace Infraestructura.Data.CrediMovilLima
{
    public class ClienteDAO : ICliente
    {
        private readonly string cadena = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

        public IEnumerable<Cliente> GetALL()
        {
            var listado = new List<Cliente>();
            var sp = "select * from Clientes.Cliente";

            try
            {
                using (SqlConnection cone = new SqlConnection(cadena))
                {
                    cone.Open();
                    SqlCommand cmd = new SqlCommand(sp, cone);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        Cliente categoria = new Cliente()
                        {
                            IdCliente = dr.GetInt32(0),
                            Nombres = dr.GetString(1),
                            Apellidos = dr.GetString(2),
                            Celular = dr.GetString(3),
                            Correo = dr.GetString(4),
                            DNI = dr.GetString(5)
                        };
                        listado.Add(categoria);
                    }
                    dr.Close();
                }
            }
            catch (Exception)
            {
                throw;
            }
            return listado;
        }

        public IEnumerable<Cliente> GetXId(int id)
        {
            throw new NotImplementedException();
        }
    }
}

