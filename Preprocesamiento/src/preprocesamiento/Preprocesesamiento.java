package preprocesamiento;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

public class Preprocesesamiento {

	// -------------------------------------------------------------------------
	// CONSTANTES
	// -------------------------------------------------------------------------

	public final static String RUTA_CSV = "./resources/dataset";

	public final static String MESSAGE_FINAL = "END_DATASET_ANOMALOUS";

	public final static int PETICION_GET = 0;
	public final static int PETICION_POST = 1;
	public final static int PETICION_PUT = 2;
	public final static int PETICION_DELETE = 3;
	public final static String[] CARACTERES_ESPECIALES = { "!", "\"", "#", "$", "%", "&", "\'", "(", ")", "*", "+", ",",
			"-", ".", "/" };
	public final static String[] EXTENSIONES_ARCHIVOS = { "EXE", "JAVA", "OLD", "BAK" };

	// --------------------------------------------------------------------------
	// ATRIBUTOS
	// --------------------------------------------------------------------------

	private PrintWriter printWriter;

	private int[] conteoPeticiones = { 0, 0, 0, 0 };

	public Preprocesesamiento(String ruta) throws IOException {
		printWriter = new PrintWriter(ruta);
		String content = reload(ruta);
		if (content.isEmpty() || content.contains(MESSAGE_FINAL)) {
			printWriter.println(
					"Peticion;URL;URL_Length;EXE;JAVA;OLD;BAK;Admiracion;ComillasDobles;Numeral;Pesos;Porcentaje;Ampersand;ComillaSimple;ParantesisAbierto;ParentesisCerrado;Asterisco;Mas;Coma;Menos;Punto;Slash;TotalCaracteres;Host;Cookie;Connection");
		} else {
			printWriter.println(content);
		}

	}

	// ---------------------------------------------------------------------------
	// METODOS
	// ---------------------------------------------------------------------------

	/**
	 * Recarga informacion contenida en el dataset
	 * 
	 * @param file
	 *            ruta del dataset
	 * @return String con toda la informacion del dataset
	 * @throws IOException
	 *             Lanza una excepcion con los aspectos relacionados a carga del
	 *             archivo
	 */
	public String reload(String file) throws IOException {
		FileReader fileReader = new FileReader(file);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		String line = bufferedReader.readLine();
		String message = "";
		while (line != null) {
			message += line + "\n";
			line = bufferedReader.readLine();
		}
		bufferedReader.close();
		return message;
	}

	public void read(String file) throws FileNotFoundException, IOException {
		FileReader fileReader = new FileReader(file);
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		String line;

		while ((line = bufferedReader.readLine()) != null) {
			getPeticion(line);
		}
		System.err.println("GET: " + conteoPeticiones[PETICION_GET] + ", POST: " + conteoPeticiones[PETICION_POST]
				+ ", PUT: " + conteoPeticiones[PETICION_PUT] + ", DELETE: " + conteoPeticiones[PETICION_DELETE]);
		printWriter.println(MESSAGE_FINAL);
		printWriter.close();
		bufferedReader.close();
	}

	public int contienePeticion(String line) {
		if (line.split(" ")[0].equals("GET")) {
			return PETICION_GET;
		}
		if (line.split(" ")[0].equals("POST")) {
			return PETICION_POST;
		}
		if (line.split(" ")[0].equals("PUT")) {
			return PETICION_PUT;
		}
		if (line.split(" ")[0].equals("DELETE")) {
			return PETICION_DELETE;
		}
		return -1;
	}

	public void getPeticion(String line) {
		switch (contienePeticion(line)) {
		case PETICION_GET:
			GET(line);
			 System.out.println("PETICION_GET -> encontrada, numero:" +
			 conteoPeticiones[PETICION_GET]++);
			break;
		case PETICION_POST:
			POST(line);
			 System.out.println("PETICION_POST -> encontrada, numero:" +
			 conteoPeticiones[PETICION_POST]++);
			break;
		case PETICION_PUT:
			PUT(line);
			 System.out.println("PETICION_PUT -> encontrada, numero:" +
			 conteoPeticiones[PETICION_PUT]++);
			break;
		case PETICION_DELETE:
			DELETE(line);
			 System.out.println("PETICION_DELETE -> encontrada, numero:" +
			 (conteoPeticiones[PETICION_DELETE]++));
			break;
		default:
			break;
		}
	}

	public void GET(String line) {
		analisisURL(line);
	}

	// Peticiones que se encargan de hacer cambios en la logica
	public void POST(String line) {
		analisisURL(line);
	}

	// Peticiones que actualizan algo
	public void PUT(String line) {
		analisisURL(line);
	}

	public void DELETE(String line) {
		analisisURL(line);
	}

	public void analisisURL(String URL) {
		String temp[] = URL.split(" ");
		int[] contadorCaracteres = new int[16];
		for (int i = 0; i < temp[1].length(); i++) {
			for (int j = 0; j < CARACTERES_ESPECIALES.length; j++) {
				if (temp[1].charAt(i) == CARACTERES_ESPECIALES[j].charAt(0)) {
					contadorCaracteres[j]++;
					contadorCaracteres[15]++;
				}
			}
		}
		printWriter.println();
		printWriter.print(temp[0] + ";" + temp[1].replaceFirst("http://localhost:8080", "") + ";" + temp[1].length());

		if (temp[1].toLowerCase().contains(".exe")) {
			printWriter.print(";1");
		} else {
			printWriter.print(";0");
		}
		if (temp[1].toLowerCase().contains(".java")) {
			printWriter.print(";1");
		} else {
			printWriter.print(";0");
		}
		if (temp[1].toLowerCase().contains(".old")) {
			printWriter.print(";1");
		} else {
			printWriter.print(";0");
		}
		if (temp[1].toLowerCase().contains(".bak")) {
			printWriter.print(";1");
		} else {
			printWriter.print(";0");
		}
		for (int i = 0; i < CARACTERES_ESPECIALES.length; i++) {
			printWriter.print(";" + contadorCaracteres[i]);
		}
		printWriter.print(";" + contadorCaracteres[15]);
		
	}

	public static void main(String[] args) {
		try {
			new Preprocesesamiento(RUTA_CSV + "_B.csv").read("./resources/anomalousTrafficTest.txt");
			new Preprocesesamiento(RUTA_CSV + "_N.csv").read("./resources/normalTrafficTraining.txt");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
