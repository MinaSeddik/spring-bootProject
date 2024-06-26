package com.example.springbootproject.service;

import com.example.springbootproject.domain.GeoIP;
import com.maxmind.geoip2.DatabaseReader;
import com.maxmind.geoip2.exception.GeoIp2Exception;
import com.maxmind.geoip2.model.CityResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.net.InetAddress;

@Service
@Slf4j
public class RawDBDemoGeoIPLocationService {

    private DatabaseReader dbReader;

//    https://www.baeldung.com/geolocation-by-ip-with-maxmind
//    public RawDBDemoGeoIPLocationService() throws IOException {
//        File database = new File("your-mmdb-location");
//        dbReader = new DatabaseReader.Builder(database).build();
//    }

    public GeoIP getLocation(String ip) throws IOException, GeoIp2Exception {
        InetAddress ipAddress = InetAddress.getByName(ip);
        CityResponse response = dbReader.city(ipAddress);

        String cityName = response.getCity().getName();
        String latitude = response.getLocation().getLatitude().toString();
        String longitude = response.getLocation().getLongitude().toString();
        return new GeoIP(ip, cityName, latitude, longitude);
    }


}
