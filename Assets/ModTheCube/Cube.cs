using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class Cube : MonoBehaviour
{
    public MeshRenderer Renderer;
    private float duration;
    void Start()
    {
        // Set the starting position for the cube
        transform.position = new Vector3(0, 8, 0);
        transform.Rotate(45, 0, 45);
        transform.localScale = Vector3.one * 1.0f;

        Material material = Renderer.material;

        material.color = new Color(0.5f, 1.0f, 0.3f, 0.4f);

        // Random duration of rotating for random results
        duration = Random.Range(0.1f, 1.0f);
        StartCoroutine(RunForSeconds(duration));
    }

    // Corutine for throw imitaion
    IEnumerator RunForSeconds(float duration)
    {
        float timer = 0f;

        while (timer < duration)
        {
            transform.Rotate(50.0f * Time.deltaTime, 50.0f, 50.0f);
            timer += Time.deltaTime;
            yield return null;
        } 
    }

    void Update()
    {

    }
}
