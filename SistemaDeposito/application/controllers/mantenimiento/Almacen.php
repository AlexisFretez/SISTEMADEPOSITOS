<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Almacen extends CI_Controller
{

	private $permisos;
	private $modulo = "Almacen";
	public function __construct()
	{
		parent::__construct();
		$this->permisos = $this->backend_lib->control();
		$this->load->model("Almacen_model");
		$this->load->model("Ventas_model");
	}

	public function index()
	{
		$data  = array(
			'permisos' => $this->permisos,
			'almacenes' => $this->Almacen_model->getAlmacenes(),
		);
		$this->load->view("layouts/header");
		$this->load->view("layouts/aside");
		$this->load->view("admin/almacen/list", $data);
		$this->load->view("layouts/footer");
	}

	public function add()
	{

		$this->load->view("layouts/header");
		$this->load->view("layouts/aside");
		$this->load->view("admin/almacen/add");
		$this->load->view("layouts/footer");
	}

	public function store()
	{

		$nombre = $this->input->post("nombre");
		$fecha_creacion = $this->input->post("fecha_creacion");
		$descripcion = $this->input->post("descripcion");
		$precio = $this->input->post("precio");

		$this->form_validation->set_rules("nombre", "Nombre", "required|is_unique[almacen.nombre]");

		if ($this->form_validation->run() == TRUE) {

			$data  = array(
				'nombre' => $nombre,
				'fecha_creacion' => $fecha_creacion,
				'descripcion' => $descripcion,
				'precio' => $precio,
				'estado' => "1"
			);

			if ($this->Almacen_model->save($data)) {
				$this->backend_lib->savelog($this->modulo, "Actualización del Office con nombre " . $nombre);
				$this->session->set_flashdata("success", "Los datos fueron guardados exitosamente");
				redirect(base_url() . "mantenimiento/almacen");
			} else {
				$this->session->set_flashdata("error", "No se pudo guardar la informacion");
				redirect(base_url() . "mantenimiento/almacen/add");
			}
		} else {
			/*redirect(base_url()."mantenimiento/categorias/add");*/
			$this->add();
		}
	}

	public function edit($id)
	{
		$data  = array(
			'almacen' => $this->Almacen_model->getAlmacen($id),
		);
		$this->load->view("layouts/header");
		$this->load->view("layouts/aside");
		$this->load->view("admin/almacen/edit", $data);
		$this->load->view("layouts/footer");
	}

	public function update()
	{
		$idAlmacen = $this->input->post("idAlmacen");
		$nombre = $this->input->post("nombre");
		$fecha_creacion = $this->input->post("fecha_creacion");
		$descripcion = $this->input->post("descripcion");
		$precio = $this->input->post("precio");

		$almacenactual = $this->Almacen_model->getAlmacen($idAlmacen);

		if ($nombre == $almacenactual->nombre) {
			$is_unique = "";
		} else {
			$is_unique = "|is_unique[almacen.nombre]";
		}


		$this->form_validation->set_rules("nombre", "Nombre", "required" . $is_unique);
		if ($this->form_validation->run() == TRUE) {
			$data = array(
				'nombre' => $nombre,
				'fecha_creacion' => $fecha_creacion,
				'descripcion' => $descripcion,
				'precio' => $precio,
			);

			if ($this->Almacen_model->update($idAlmacen, $data)) {
				$this->backend_lib->savelog($this->modulo, "Actualización del Office con nombre " . $nombre);
				$this->session->set_flashdata("success", "Los datos fueron Editados exitosamente");
				redirect(base_url() . "mantenimiento/almacen");
			} else {
				$this->session->set_flashdata("error", "No se pudo actualizar la informacion");
				redirect(base_url() . "mantenimiento/almacen/edit/" . $idAlmacen);
			}
		} else {
			$this->edit($idAlmacen);
		}
	}

	public function view($id)
	{
		$data  = array(
			'almacen' => $this->Almacen_model->getAlmacen($id),
		);
		$this->load->view("admin/almacen/view", $data);
	}

	public function delete($id)
	{
		$data  = array(
			'estado' => "0",
		);
		$this->Almacen_model->update($id, $data);
		echo "mantenimiento/almacen";
	}
}
