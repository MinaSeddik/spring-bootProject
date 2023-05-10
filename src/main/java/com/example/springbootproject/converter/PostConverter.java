package com.example.springbootproject.converter;

import com.example.springbootproject.domain.Post;
import com.example.springbootproject.dto.PostDto;
import lombok.extern.slf4j.Slf4j;
import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Collection;

@Component
@Slf4j
public class PostConverter extends AppConverter {


    @Autowired
    public PostConverter(ModelMapper modelMapper) {
        super(modelMapper);
    }

    @Override
    public void configure(ModelMapper modelMapper) {

        log.info("#@#@#@#@#@ >>>>>>>>>>> Configuring PostConverter  .... ");

        TypeMap<Post, PostDto> propertyMapper = modelMapper.createTypeMap(Post.class, PostDto.class);

        // setup
        // have different property name
        propertyMapper.addMapping(Post::getTimestamp, PostDto::setCreationDate);

        // setup
        // add deep mapping to flatten source's creator object into a single field in destination
        propertyMapper.addMappings(
                mapper -> mapper.map(src -> src.getCreator().getUsername(), PostDto::setUsername)
        );

        // setup
        // skip property
        propertyMapper.addMappings(mapper -> mapper.skip(PostDto::setId));

        // setup
        // converter one type to another type
        Converter<Collection, Integer> collectionToSize = c -> c.getSource().size();
        propertyMapper.addMappings(
                mapper -> mapper.using(collectionToSize).map(Post::getComments, PostDto::setCommentCount)
        );

        // and more setup as needed .....
    }
}
