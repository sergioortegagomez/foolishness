package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._

class BasicSimulation extends Simulation {

  val httpProtocol = http.baseUrl("http://web/api")

  val scn = scenario("BasicSimulation")
    .exec(http("/").get("/"))
    .exec(http("/go").get("/go"))
    .exec(http("/php").get("/php"))
    .exec(http("/java").get("/java"))
    .exec(http("/vote/list").get("/vote/list"))
    .exec(http("/vote/create").post("/vote/create").body(StringBody("vote=Yes")))
    .exec(http("/vote/create").post("/vote/create").body(StringBody("vote=No")))
    .exec(http("/vote/create").post("/vote/create").body(StringBody("vote=Maybe")))
  setUp(
    scn.inject(
      nothingFor(4 seconds),
      atOnceUsers(10),
      rampUsers(10) during (5 seconds),
      constantUsersPerSec(20) during (15 seconds),
      constantUsersPerSec(20) during (15 seconds) randomized,
      rampUsersPerSec(10) to 20 during (2 minutes),
      rampUsersPerSec(10) to 20 during (2 minutes) randomized,
      heavisideUsers(5000) during (60 seconds)
    )
  ).protocols(httpProtocol)

}