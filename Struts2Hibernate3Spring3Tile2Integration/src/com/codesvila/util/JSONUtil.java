package com.codesvila.util;

//import com.fasterxml.jackson.annotation.JsonInclude.Include;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.databind.SerializationFeature;
//import com.idmission.util.GlobalConstants;

/**
 * 
 */
public class JSONUtil {
//
//  private static final Logger LOG                = Logger.getLogger(JSONUtil.class);
//  private static ObjectMapper mapper             = new ObjectMapper();
//  private static boolean      isMapperConfigured = false;
//
//  /**
//   * {@link ObjectMapper#writeValueAsString(Object)}
//   * 
//   * @param obj
//   * @return
//   */
//  public static String serialize(Object obj) {
//    synchronized (mapper) {
//      if (!isMapperConfigured) {
//        /* configure the mapper not to serialize the null values. */
//        mapper.configure(SerializationFeature.WRITE_NULL_MAP_VALUES, false);
//        mapper.setSerializationInclusion(Include.NON_NULL);
//        isMapperConfigured = true;
//      }
//    }
//    try {
//      return mapper.writeValueAsString(obj);
//    } catch (Exception e) {
//      if (LOG.isDebugEnabled()) {
//        LOG.error("JSONUtil.serialize - Error - ", e);
//      } else {
//        LOG.error("JSONUtil.serialize - Error - " + e);
//      }
//
//    }
//    return null;
//  }
//
//  /**
//   * {@link ObjectMapper#readValue(byte[], Class)}
//   * 
//   * @param <T>
//   * @param strJson
//   * @param clazz
//   * @return
//   * @throws Exception
//   */
//  public static <T> T deserialize(String strJson, Class<T> clazz) throws Exception {
//    try {
//
//      T output = mapper.readValue(strJson.getBytes(GlobalConstants.UTF8), clazz);
//      return output;
//    } catch (Exception e) {
//
//      LOG.debug(e);
//    }
//
//    return null;
//  }
}
