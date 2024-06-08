using Infraestructura.Data.CrediMovilLima;
using System.Web.Mvc;

namespace CrediMovilLima.Controllers
{
    public class PruebaController : Controller
    {
        ClienteDAO _clienteDAO = new ClienteDAO();
        public ActionResult Index()
        {
            return View(_clienteDAO.GetALL());
        }
    }
}