data class ArbeidserfaringRequest(
        val stilling: String,
        val beskrivelse?: String,
        val fraDato: String, // Format: "2016-10
        val tilDato?: String, // Format: "2019-12
        val nåværende: Boolean
)
