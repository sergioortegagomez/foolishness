package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.concurrent.duration._

class BasicSimulation extends Simulation {

  val httpProtocol = http.baseUrl("http://front-api-node:3000")

  val scn = scenario("BasicSimulation")
    .exec(http("/").get("/"))
    .exec(http("/go").get("/go"))
    .exec(http("/php").get("/php"))
    .exec(http("/java").get("/java"))
    .exec(http("/randomnumbers/list").get("/randomnumbers/list"))
    .exec(http("/randomnumbers/create").post("/randomnumbers/create"))
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