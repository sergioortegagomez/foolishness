package simulations

import io.gatling.core.Predef._
import io.gatling.http.Predef._

import scala.util.Random
import scala.concurrent.duration._

class BasicSimulation extends Simulation {

  val httpProtocol = http.baseUrl("http://front-api-node:3000")

  def random() = Random.nextInt(5000)

  val scn = scenario("BasicSimulation")
    .exec(http("/").get("/"))
    .exec(http("/go").get("/go"))
    .exec(http("/php").get("/php"))

  setUp(
    scn.inject(constantUsersPerSec(1000) during(10 seconds))
  ).protocols(httpProtocol)

}