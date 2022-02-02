package com.njegg;

import org.springframework.core.convert.converter.Converter;

import com.njegg.repository.CubeTypeRepo;

import model.CubeType;

public class CubeTypeConverter implements Converter<String, CubeType> {

	CubeTypeRepo ctr;
	
	public CubeTypeConverter(CubeTypeRepo ctr) {
		this.ctr = ctr;
	}

	@Override
	public CubeType convert(String source) {
		int id = -1;
		try {
			id = Integer.parseInt(source);
		} catch (NumberFormatException e) {
			return null;
		}
		
		return ctr.findById(id).orElseThrow();
	}

}
