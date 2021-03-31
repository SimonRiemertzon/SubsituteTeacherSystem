package se.yrgo.schedule.format;
import se.yrgo.schedule.domain.*;

import java.util.List;

public interface Formatter {
  public String format(List<Assignment> assignments);
}
