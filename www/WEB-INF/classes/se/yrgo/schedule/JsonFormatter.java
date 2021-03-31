package se.yrgo.schedule;

import java.util.List;
import org.json.*;

/**
 * A class implementing the Formatter interface. Formats a List of Assignment to
 * JSON.
 *
 */
public class JsonFormatter implements Formatter {
  public String format(List<Assignment> assignments) {
    if (assignments.isEmpty()) {
      return "[]";
    } else {
      JSONArray JSON = new JSONArray();
      for (Assignment assignment : assignments) {
        JSON.put(JSONAssignment(assignment));
      }
      return JSON.toString(2);
    }
  }

  /* Creates one JSON object from one assignment */
  private JSONObject JSONAssignment(Assignment assignment) {
    //JSONTokener jt = new JSONTokener(); ??? <---- vad gör denna?
    JSONObject JSONAssignment = new JSONObject();
    JSONObject JSONSubstitute = new JSONObject();
    JSONObject JSONSchool = new JSONObject();
    JSONSubstitute.put("name", assignment.teacher().name());
    JSONSchool.put("school_name", assignment.school().name());
    JSONSchool.put("adress", assignment.school().adress());
    JSONAssignment.put("date", assignment.date());
    JSONAssignment.put("subtitute", JSONSubstitute);
    JSONAssignment.put("school", JSONSchool);
    return JSONAssignment;
  }

}
