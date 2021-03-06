/**
 * @author Jeremy Fontaine
 * 
 */
import java.util.HashMap;


import org.xml.sax.*;
import org.xml.sax.helpers.* ;

public class Superficie extends DefaultHandler
{
	
	/**
	 * key = id maison
	 * value = surface
	 */
	private HashMap<Integer, Double> superficieMaisons;
	private int currentId;
	private boolean inElementSurface;
	private String currentNameElementSurface;
	
	public Superficie() 
	{
		super();
		this.superficieMaisons = new HashMap<Integer, Double>();
		this.currentId=-1;
		this.inElementSurface=false;
	}
	
	public void add(int id, Double surface)
	{
		if(this.superficieMaisons.containsKey(id))
		{
			this.superficieMaisons.put(id, superficieMaisons.get(id)+surface);
		}
		else 
		{
			this.superficieMaisons.put(id, surface);
		}
	}
	
	public void print()
	{
		for(Integer key: superficieMaisons.keySet())
		{
			System.out.println("Maison "+key+":");
			System.out.println("\tSuperficie totale : "+superficieMaisons.get(key)+" m2");
		}
	}
	
	

	public void startElement(String nameSpaceURI, String localName, String rawName, Attributes attributs) throws SAXException 
	{
		double surface;
		
		for (int index = 0; index < attributs.getLength(); index++) 
		{ 
			/* get the id */
			if(attributs.getLocalName(index).equalsIgnoreCase("id"))
			{
				currentId = Integer.parseInt(attributs.getValue(index));
			}
			
			/* get the surface */
			if(attributs.getLocalName(index).equalsIgnoreCase("surface-m2"))
			{
				
				currentNameElementSurface = localName;
				surface = Double.parseDouble(attributs.getValue(index));
				
				/* if not in element with attribut surface-m2 */
				if(!inElementSurface)
				{
					this.add(currentId, surface);
				}
				/* now we are in surface element */
				this.inElementSurface = true;
			}
		}
	}
	
	
	public void endElement(String nameSpaceURI, String localName, String rawName) throws SAXException 
	{
		
		if(localName.equalsIgnoreCase(currentNameElementSurface))
				inElementSurface = false;
	}
	

	
	public static void main(String[] args) 
	{
		try {
			Superficie s = new Superficie();
			XMLReader saxReader = XMLReaderFactory.createXMLReader();
			saxReader.setContentHandler(s);
			saxReader.parse(args[0]);
			s.print();
			
		} catch (Exception t) {
			t.printStackTrace();
		}
	}
	

}
